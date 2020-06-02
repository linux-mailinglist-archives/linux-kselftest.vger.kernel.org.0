Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D1D1EB869
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jun 2020 11:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgFBJZD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jun 2020 05:25:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:54074 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgFBJZD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jun 2020 05:25:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 98914AEE8;
        Tue,  2 Jun 2020 09:25:03 +0000 (UTC)
Date:   Tue, 2 Jun 2020 11:25:00 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Yannick Cote <ycote@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        joe.lawrence@redhat.com
Subject: Re: [PATCH 2/4] selftests/livepatch: rework test-klp-shadow-vars
Message-ID: <20200602092500.GJ27273@linux-b0ei>
References: <20200528134849.7890-1-ycote@redhat.com>
 <20200528134849.7890-3-ycote@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528134849.7890-3-ycote@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu 2020-05-28 09:48:47, Yannick Cote wrote:
> The initial idea was to make a change to please cppcheck and remove void
> pointer arithmetics found a few times:
> 
> 	portability: 'obj' is of type 'void *'. When using void pointers
> 	             in calculations, the behaviour is undefined.
> 		     [arithOperationsOnVoidPointer]
> 
> The rest of the changes are to help make the test read as an example
> while continuing to verify the shadow variable code. The logic of the
> test is unchanged but restructured to use descriptive names.

First, I really like this change. There are only few comments, see below.

> Signed-off-by: Yannick Cote <ycote@redhat.com>
> ---
>  lib/livepatch/test_klp_shadow_vars.c | 101 +++++++++++++++------------
>  1 file changed, 57 insertions(+), 44 deletions(-)
> 
> diff --git a/lib/livepatch/test_klp_shadow_vars.c b/lib/livepatch/test_klp_shadow_vars.c
> index f0b5a1d24e55..ec2635cff974 100644
> --- a/lib/livepatch/test_klp_shadow_vars.c
> +++ b/lib/livepatch/test_klp_shadow_vars.c
> + * The main test case adds/removes new fields (shadow var) to each of these
> + * test structure instances. The last group of fields in the struct represent
> + * the idea that shadow variables may be added and removed to and from the
> + * struct during execution.
> + */
> +struct test_object {
> +	 /* add anything here below and avoid to define an empty struct */
> +	struct shadow_ptr sp;

I was confused why the orignal structure included shadow pointer
from the start. And it is because struct shadow_ptr is unrelated
to the tested livepatch shadow variable API.

This selftest is quite complicated even without this confusion.
It would be nice to rename struct shadow_ptr to struct ptr_id and
the varible to p_id. Or something to something like this.

It should be done in separate patch before or on top of this patchset.
I could send it if you do not want to invest more time into it.

>  
> -	int **sv;
> +	/* these represent shadow vars added and removed with SV_ID{1,2} */
> +	/* char nfield1; */
> +	/* int  nfield2; */
> +};
>  
> @@ -188,23 +200,24 @@ static int test_klp_shadow_vars_init(void)
>  	 * Verify we can find our new shadow variables and that they point
>  	 * to expected data.
>  	 */
> -	sv = shadow_get(obj, id);
> +	sv = shadow_get(&obj1, SV_ID1);
>  	if (!sv)
>  		return -EINVAL;
> -	if (sv == sv1 && *sv1 == pv1)
> +	if ((char **)sv == sv1 && *sv1 == pnfield1)

Are these casts of "sv" variable enough to get rid of the cppcheck
warnings? It would have been better to split the two changes
(warning fixes and code refactoring into two patches).

It is a hint for future patchse. I do not want to block this one
because of it. Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
