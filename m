Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C881EB8FB
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jun 2020 11:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgFBJ5w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jun 2020 05:57:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:42386 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgFBJ5w (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jun 2020 05:57:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 19BF4AC46;
        Tue,  2 Jun 2020 09:57:53 +0000 (UTC)
Date:   Tue, 2 Jun 2020 11:57:50 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Yannick Cote <ycote@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        joe.lawrence@redhat.com
Subject: Re: [PATCH 4/4] selftests/livepatch: fix mem leaks in
 test-klp-shadow-vars
Message-ID: <20200602095750.GK27273@linux-b0ei>
References: <20200528134849.7890-1-ycote@redhat.com>
 <20200528134849.7890-5-ycote@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528134849.7890-5-ycote@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu 2020-05-28 09:48:49, Yannick Cote wrote:
> In some cases, when an error occurs during testing and the main test
> routine returns, a memory leak occurs via leaving previously registered
> shadow variables allocated in the kernel as well as shadow_ptr list
> elements. From now on, in case of error, remove all allocated shadow
> variables and shadow_ptr struct elements.
> 
> Signed-off-by: Yannick Cote <ycote@redhat.com>
> ---
>  lib/livepatch/test_klp_shadow_vars.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/livepatch/test_klp_shadow_vars.c b/lib/livepatch/test_klp_shadow_vars.c
> index 195309e1edf3..c6d631d826e0 100644
> --- a/lib/livepatch/test_klp_shadow_vars.c
> +++ b/lib/livepatch/test_klp_shadow_vars.c
> @@ -170,6 +170,7 @@ static int test_klp_shadow_vars_init(void)
>  	char *pndup[NUM_OBJS];
>  	int nfields2[NUM_OBJS], *pnfields2[NUM_OBJS], **sv2[NUM_OBJS];
>  	void **sv;
> +	int ret = -EINVAL;

IMHO, this predefined error value adds more hard than good. It makes
the code hard to read. One has to jump up and down to check what error
will get returned. Also it is safe only when "goto out" is used right
after setting this variable.


>  	int i;
>  
>  	ptr_id(NULL);
> @@ -192,12 +193,16 @@ static int test_klp_shadow_vars_init(void)
>  		/* alloc a few svars with different <obj> and <id>. */
>  		sv1[i] = shadow_alloc(&objs[i], SV_ID1, sizeof(pnfields1[i]),
>  					GFP_KERNEL, shadow_ctor, &pnfields1[i]);
> -		if (!sv1[i])
> -			return -ENOMEM;
> +		if (!sv1[i]) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
>  		sv2[i] = shadow_alloc(&objs[i], SV_ID2, sizeof(pnfields2[i]),
>  					GFP_KERNEL, shadow_ctor, &pnfields2[i]);
> -		if (!sv2[i])
> -			return -ENOMEM;
> +		if (!sv2[i]) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
>  	}
>  
>  	/* pass 2: verify we find allocated svars and where they point to */
> @@ -205,7 +210,7 @@ static int test_klp_shadow_vars_init(void)
>  		/* check the "char" svar for all objects */
>  		sv = shadow_get(&objs[i], SV_ID1);
>  		if (!sv)
> -			return -EINVAL;
> +			goto out;

Please, replace also return -EINVAL with

			ret = -EINVAL;
			goto out;


With this change:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
