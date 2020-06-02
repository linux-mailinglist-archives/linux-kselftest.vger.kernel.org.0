Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EADB1EBBC9
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jun 2020 14:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgFBMf7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jun 2020 08:35:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:43764 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgFBMf7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jun 2020 08:35:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 23F7DABD1;
        Tue,  2 Jun 2020 12:36:00 +0000 (UTC)
Date:   Tue, 2 Jun 2020 14:35:57 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Yannick Cote <ycote@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        joe.lawrence@redhat.com
Subject: Re: [PATCH 3/4] selftests/livepatch: more verification in
 test-klp-shadow-vars
Message-ID: <20200602123557.GL27273@linux-b0ei>
References: <20200528134849.7890-1-ycote@redhat.com>
 <20200528134849.7890-4-ycote@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528134849.7890-4-ycote@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu 2020-05-28 09:48:48, Yannick Cote wrote:
> This change makes the test feel more familiar with narrowing to a
> typical usage by operating on a number of identical structure instances
> and populating the same two new shadow variables symmetrically while
> keeping the same testing and verification criteria for the extra
> variables.
> 
> @@ -157,122 +165,96 @@ struct test_object {
>  
>  static int test_klp_shadow_vars_init(void)
>  {
> -	struct test_object obj1, obj2, obj3;
> -	char nfield1, nfield2, *pnfield1, *pnfield2, **sv1, **sv2;
> -	int  nfield3, nfield4, *pnfield3, *pnfield4, **sv3, **sv4;
> +	struct test_object objs[NUM_OBJS];
> +	char nfields1[NUM_OBJS], *pnfields1[NUM_OBJS], **sv1[NUM_OBJS];
> +	char *pndup[NUM_OBJS];
> +	int nfields2[NUM_OBJS], *pnfields2[NUM_OBJS], **sv2[NUM_OBJS];
>  	void **sv;

> +	/* pass 1: init & alloc a char+int pair of svars for each objs */
> +	for (i = 0; i < NUM_OBJS; i++) {
> +		pnfields1[i] = &nfields1[i];
> +		pnfields2[i] = &nfields2[i];
> +		ptr_id(pnfields1[i]);
> +		ptr_id(pnfields2[i]);
> +
> +		/* alloc a few svars with different <obj> and <id>. */
> +		sv1[i] = shadow_alloc(&objs[i], SV_ID1, sizeof(pnfields1[i]),
> +					GFP_KERNEL, shadow_ctor, &pnfields1[i]);
> +		if (!sv1[i])
> +			return -ENOMEM;

Please, put empty line here to delimit ID1 ID2 handling a bit.

Also I have got a bit more predictable PTR IDs when I moved pnfields2
initialization here:

		pnfields2[i] = &nfields2[i];
		ptr_id(pnfields2[i]);

> +		sv2[i] = shadow_alloc(&objs[i], SV_ID2, sizeof(pnfields2[i]),
> +					GFP_KERNEL, shadow_ctor, &pnfields2[i]);
> +		if (!sv2[i])
> +			return -ENOMEM;
> +	}

It looks like:

test_klp_shadow_vars: klp_shadow_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR2 = PTR3
test_klp_shadow_vars: shadow_ctor: PTR6 -> PTR5
test_klp_shadow_vars: klp_shadow_alloc(obj=PTR1, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR5 = PTR6
test_klp_shadow_vars: shadow_ctor: PTR8 -> PTR7
test_klp_shadow_vars: klp_shadow_alloc(obj=PTR9, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR4, ctor_data=PTR7 = PTR8
test_klp_shadow_vars: shadow_ctor: PTR11 -> PTR10

instead of

test_klp_shadow_vars: klp_shadow_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR5, ctor_data=PTR2 = PTR4
test_klp_shadow_vars: shadow_ctor: PTR6 -> PTR3
test_klp_shadow_vars: klp_shadow_alloc(obj=PTR1, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR5, ctor_data=PTR3 = PTR6
test_klp_shadow_vars: shadow_ctor: PTR9 -> PTR7
test_klp_shadow_vars: klp_shadow_alloc(obj=PTR10, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR5, ctor_data=PTR7 = PTR9
test_klp_shadow_vars: shadow_ctor: PTR11 -> PTR8


By other words, the PTR IDs are incrementing by the same offset for
both SV_ID1 and SV_ID2. It looks better even later in the log.


> +	/* pass 3: verify that 'get_of_alloc' returns already allocated svars */
> +	for (i = 0; i < NUM_OBJS; i++) {
> +		sv = shadow_get_or_alloc(&objs[i], SV_ID1, sizeof(pndup[i]),
> +					GFP_KERNEL, shadow_ctor, &pndup[i]);

First, the test failed on my system. I have got:

# --- expected
# +++ result
# @@ -27,20 +27,20 @@ test_klp_shadow_vars: klp_shadow_get(obj
#  test_klp_shadow_vars:   got expected PTR16 -> PTR13 result
#  test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR5, ctor_data=PTR17 = PTR4
#  test_klp_shadow_vars:   got expected PTR4 -> PTR2 result
# -test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR10, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR5, ctor_data=PTR18 = PTR9
# +test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR10, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR5, ctor_data=PTR0 = PTR9
#  test_klp_shadow_vars:   got expected PTR9 -> PTR7 result
# -test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR15, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR5, ctor_data=PTR19 = PTR14
# +test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR15, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR5, ctor_data=PTR0 = PTR14

In my build, it uses PTR0 for ctor_data. But it takes a new pointer in
your case.

It is because pndup[i] was not initialized. Note that it is the value (data)
that is stored in the shadow variable.

The solution is to initialize pndup[i] here:

		pndup[i] = &nfields1[i];
		ptr_id(pndup[i]);


2nd problem, klp_shadow_get_or_alloc() is always
called for already allocated values now. It would be great to test
that they can be created when they are not available.

A solution might be to allocate half of the variables by
shadow_alloc() and the other half with shadow_get_or_alloc().
I would do this in the first cycle, using:

	if (i % 2) {
		sv1[i] = shadow_alloc(&objs[i], SV_ID1, sizeof(pnfields1[i]),
				GFP_KERNEL, shadow_ctor, &pnfields1[i]);
	} else {
		sv1[i] = shadow_get_or_alloc(&objs[i], SV_ID1, sizeof(pnfields1[i]),
				GFP_KERNEL, shadow_ctor, &pnfields1[i]);
	}

Otherwise, it is a nice clean up.

Best Regards,
Petr
