Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3B476E461
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 11:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbjHCJav (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 05:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbjHCJag (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 05:30:36 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6F4213F;
        Thu,  3 Aug 2023 02:30:35 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-563dc551518so372225a12.2;
        Thu, 03 Aug 2023 02:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691055035; x=1691659835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FUnv55wfTun/T0T1ZYocDcSaWOaVLVKuOcFcMjLuj0c=;
        b=H9SnDXyJJJnbf7sHjW3Hs8qT0glkUmsvOMhKEiU2yX+JymYzE7F7zVodVtMV7N7Akv
         zg6ejzDAtd8WeosGfkdMykD4I/W+n5plY1SiEiOLAJEua46hoa7Bg2313YHfxrfcqMi7
         EEh/ez+EwxEFpoaXBFPmqzye/HLix1jlZ75A7eF1s4yGXZuTAbbr9r+TdbHU/bF/ERRR
         NAVb5gTklSOGPdXrHlqP12mBQ4AyqjRZBEwZUmkPJlfZPrDFL2iTG5KkHwbjIcyKGlRx
         0ZA8JWFVMVYIq1q+RtlqG7bdOYtxEPmV4T/4lOz0YkMbVYOvlvJEaCzRum8HdtWG8o9l
         GtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691055035; x=1691659835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUnv55wfTun/T0T1ZYocDcSaWOaVLVKuOcFcMjLuj0c=;
        b=jV5vXYLyWsbmz68KksckD09AHT8D8LKhJpOfTFG0PzH4FAao7Jbun3EnJSrjKCv83K
         WvPo9z9YfLffDTDSrgwoHxPSfzzHp7BVyx45GS/wbTND+hhjSwZT1nG2L9bUlTxzzrPM
         AnaQT3D2WnMOL4KBo+LqIC4GwBS7/5Ian2xNqDQBM8fFN50oYIxVlcWlD4UtxKi+U4Kz
         Q++mhA7G6GL/NNycTc1oBLHdL2HwnMbpTWmClNz7d5DjKQrHNo4rrpXbseaZhxaDFiFO
         OFuTTiMmmwjSUqtHGFpr12N6bPWiWM0jR4zFnTQSRsX5+8RGWGY4DGVGNAvytrCVrDfu
         P/7A==
X-Gm-Message-State: ABy/qLYQHulLkPcCRxvAnQ/P+aJGTjOadSbWzBJEVO8bBjOlYD7pmZaN
        p3WIM9eEizrOoXsAd3ijhwQ=
X-Google-Smtp-Source: APBJJlFFm/tLNbGm0LgXgDpoO0ciWpOBJYmO7ie++yo+qlSpQvSGq5v6Bw0hhAYlDsRLBqzUtEImqg==
X-Received: by 2002:a17:90b:1d88:b0:268:c569:f2b0 with SMTP id pf8-20020a17090b1d8800b00268c569f2b0mr9641562pjb.1.1691055034957;
        Thu, 03 Aug 2023 02:30:34 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id i14-20020a17090acf8e00b00267ae12b80bsm2237282pju.34.2023.08.03.02.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 02:30:34 -0700 (PDT)
Date:   Thu, 3 Aug 2023 17:30:28 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Andrea Mayer <andrea.mayer@uniroma2.it>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels.dev@gmail.com>
Subject: Re: [net-next 1/2] seg6: add NEXT-C-SID support for SRv6 End.X
 behavior
Message-ID: <ZMtztGiOWV6bqCLg@Laptop-X1>
References: <20230731175117.17376-1-andrea.mayer@uniroma2.it>
 <20230731175117.17376-2-andrea.mayer@uniroma2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731175117.17376-2-andrea.mayer@uniroma2.it>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 31, 2023 at 07:51:16PM +0200, Andrea Mayer wrote:
> +/* Processing of SRv6 End, End.X, and End.T behaviors can be extended through
> + * the flavors framework. These behaviors must report the subset of (flavor)
> + * operations they currently implement. In this way, if a user specifies a
> + * flavor combination that is not supported by a given End* behavior, the
> + * kernel refuses to instantiate the tunnel reporting the error.
> + */
> +static int seg6_flv_supp_ops_by_action(int action, __u32 *fops)
> +{
> +	switch (action) {
> +	case SEG6_LOCAL_ACTION_END:
> +		*fops = SEG6_LOCAL_END_FLV_SUPP_OPS;
> +		break;
> +	case SEG6_LOCAL_ACTION_END_X:
> +		*fops = SEG6_LOCAL_END_X_FLV_SUPP_OPS;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
>  }
>  

...

> @@ -2070,7 +2131,8 @@ static int parse_nla_flavors(struct nlattr **attrs, struct seg6_local_lwt *slwt,
>  {
>  	struct seg6_flavors_info *finfo = &slwt->flv_info;
>  	struct nlattr *tb[SEG6_LOCAL_FLV_MAX + 1];
> -	unsigned long fops;
> +	int action = slwt->action;
> +	__u32 fops, supp_fops = 0;
>  	int rc;
>  
>  	rc = nla_parse_nested_deprecated(tb, SEG6_LOCAL_FLV_MAX,
> @@ -2086,7 +2148,8 @@ static int parse_nla_flavors(struct nlattr **attrs, struct seg6_local_lwt *slwt,
>  		return -EINVAL;
>  
>  	fops = nla_get_u32(tb[SEG6_LOCAL_FLV_OPERATION]);
> -	if (fops & ~SEG6_LOCAL_FLV_SUPP_OPS) {
> +	rc = seg6_flv_supp_ops_by_action(action, &supp_fops);
> +	if (rc < 0 || !supp_fops || (fops & ~supp_fops)) {

if rc == 0, the supp_fops won't be 0.

Thanks
Hangbin
