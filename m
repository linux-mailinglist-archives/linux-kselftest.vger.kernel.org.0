Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B800D770EB8
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 10:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjHEIRN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 04:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHEIRM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 04:17:12 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B827B10CF;
        Sat,  5 Aug 2023 01:17:10 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bb9e6c2a90so24961265ad.1;
        Sat, 05 Aug 2023 01:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691223430; x=1691828230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TXWtO68B908Vgsw1fC92ZeReeNRVFDeUQ1ixcNe4Hxc=;
        b=JvBTDLa6NXdxjNGd5Z5U4/kUZ8z8D7dlbvEh3P1LGvT+04RFW6/cv6/RfzYKTuQUvo
         VMm+Zq0L7frWVtRW1HeqJjTMaz12JOoo7NdWacgstDFQIy+RnmkJfWie3xl/1PL/aLru
         fCssJwtDXl3p5IXUGa5AQHqaT7dVXscFbVlFR3E+EjXMJXBkwSVVNm9v6h7kUOWV0W5r
         nM4n6+1gIf9uINMcEr9M+fErcLKCOM0tA0rXxiBpL7D9Z14lmxPAVsEiW1olAuyeEF4I
         lG/9i3uVpCREcTNCVQPezecrgX92334RhxY69mU+UnIZDWTCtZG+fgXXaJBX5Nd4Jb+A
         lnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691223430; x=1691828230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXWtO68B908Vgsw1fC92ZeReeNRVFDeUQ1ixcNe4Hxc=;
        b=JnBas0ZbFkrdz00dOT5n9jskirKoVUMzqCi4vWJ5KvVfR+I8d0wz7FhQAiXi6yysUB
         QeGS8Rm6As4fMj5N0gKt97jE9rbYthDVsaDa08AvItBLEbQqNd36t9IBHw2mo9UsbQ0a
         4zA34g1cZFjjLSfodQ2ZLVRcADRNfLjOZrP5ybq4kxuKN4GwMD3Au26NYdYLosrEXEM4
         E+zkCsXQMef5ui6SdGfic1TC13//X3G65g5mzkejZxdpgGAOPZpTwJ61UsK8HmC0TiCc
         Dx0q4Eaa6oatxZGuvIX9Sv9Ozezo2/jVWsaiKs9WOkp8/VmbHttdP85M1TiRawKhEDOU
         lKow==
X-Gm-Message-State: AOJu0Yw9l07i1KUfKsxARhK//1j9bA+amiioO7kI/Y3zBQEL6bbiUPnS
        /2xUNXV7qfQVVx82ivq+aJk=
X-Google-Smtp-Source: AGHT+IGssXUuQzuTrIcE2xIf7rO2rVAMx3xmsq4oOx9h1orCvPjI+O5evhqoKs51mFwTvu9St4YwRQ==
X-Received: by 2002:a17:903:41c6:b0:1bb:ab0d:4f76 with SMTP id u6-20020a17090341c600b001bbab0d4f76mr5446161ple.58.1691223430032;
        Sat, 05 Aug 2023 01:17:10 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902bd0700b001b3bf8001a9sm2972255pls.48.2023.08.05.01.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 01:17:08 -0700 (PDT)
Date:   Sat, 5 Aug 2023 16:17:03 +0800
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
Message-ID: <ZM4Ff0Rk2SBiDdC0@Laptop-X1>
References: <20230731175117.17376-1-andrea.mayer@uniroma2.it>
 <20230731175117.17376-2-andrea.mayer@uniroma2.it>
 <ZMtztGiOWV6bqCLg@Laptop-X1>
 <20230804144118.a52808dc5fecda09751fae9d@uniroma2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804144118.a52808dc5fecda09751fae9d@uniroma2.it>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 04, 2023 at 02:41:18PM +0200, Andrea Mayer wrote:
> Hi Hangbin,
> thanks for your time. Please see below.
> 
> On Thu, 3 Aug 2023 17:30:28 +0800
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
> > On Mon, Jul 31, 2023 at 07:51:16PM +0200, Andrea Mayer wrote:
> > > +/* Processing of SRv6 End, End.X, and End.T behaviors can be extended through
> > > + * the flavors framework. These behaviors must report the subset of (flavor)
> > > + * operations they currently implement. In this way, if a user specifies a
> > > + * flavor combination that is not supported by a given End* behavior, the
> > > + * kernel refuses to instantiate the tunnel reporting the error.
> > > + */
> > > +static int seg6_flv_supp_ops_by_action(int action, __u32 *fops)
> > > +{
> > > +	switch (action) {
> > > +	case SEG6_LOCAL_ACTION_END:
> > > +		*fops = SEG6_LOCAL_END_FLV_SUPP_OPS;
> > > +		break;
> > > +	case SEG6_LOCAL_ACTION_END_X:
> > > +		*fops = SEG6_LOCAL_END_X_FLV_SUPP_OPS;
> > > +		break;
> > > +	default:
> > > +		return -EOPNOTSUPP;
> > > +	}
> > > +
> > > +	return 0;
> > >  }
> > >  
> > 
> > ...
> > 
> > > @@ -2070,7 +2131,8 @@ static int parse_nla_flavors(struct nlattr **attrs, struct seg6_local_lwt *slwt,
> > >  {
> > >  	struct seg6_flavors_info *finfo = &slwt->flv_info;
> > >  	struct nlattr *tb[SEG6_LOCAL_FLV_MAX + 1];
> > > -	unsigned long fops;
> > > +	int action = slwt->action;
> > > +	__u32 fops, supp_fops = 0;
> > >  	int rc;
> > >  
> > >  	rc = nla_parse_nested_deprecated(tb, SEG6_LOCAL_FLV_MAX,
> > > @@ -2086,7 +2148,8 @@ static int parse_nla_flavors(struct nlattr **attrs, struct seg6_local_lwt *slwt,
> > >  		return -EINVAL;
> > >  
> > >  	fops = nla_get_u32(tb[SEG6_LOCAL_FLV_OPERATION]);
> > > -	if (fops & ~SEG6_LOCAL_FLV_SUPP_OPS) {
> > > +	rc = seg6_flv_supp_ops_by_action(action, &supp_fops);
> > > +	if (rc < 0 || !supp_fops || (fops & ~supp_fops)) {
> > 
> > if rc == 0, the supp_fops won't be 0.
> > 
> 
> Yes, you're right.
> 
> In this patch, supp_fops is always set properly when rc == 0.
> Since seg6_flv_supp_ops_by_action() should be extended in the event that other
> behaviors receive flavors support, I added this check in case the "supp_fops"
> field was set incorrectly or not set at all.
> Note that supp_fops == 0 must be considered an inadmissible value.
> 
> 
> So, I think we have two possibilities:
>   i) remove this "defensive" check, assuming that supp_fops will always be set
>      correctly by seg6_flv_supp_ops_by_action() (when rc == 0, like in this
>      patch); 
>  ii) improve the check by explicitly indicating with a pr_warn_once, for
>      example, the condition that is occurring is unexpected.
> 
> for (ii), something like this:
> 
> parse_nla_flavors(...)
> {
>     [...]
>     supp_fops = 0;
>     [...]
> 
>     rc = seg6_flv_supp_ops_by_action(action, &supp_fops);
>     if (!rc && !supp_fops) {
>    	 /* supported flavors mask cannot be zero as it is considered to
>    	  * be invalid.
>    	  */
>    	 pr_warn_once("seg6local: invalid Flavor operation(s)");
>    	 return -EINVAL;
>     }

Do you mean there is a possibility *in future* that the supp_fops could be 0
with rc == 0? If yes, this check would make sense(although we can add this
check when it's true). If not. I don't see a need to have this check.

And some static analysis tool would report warn for this code.

Thanks
Hangbin
> 
>     fops = nla_get_u32(tb[SEG6_LOCAL_FLV_OPERATION]);
>     if (rc < 0 || (fops & ~supp_fops)) {
>    	 NL_SET_ERR_MSG(extack, "Unsupported Flavor operation(s)");
>    	 return -EOPNOTSUPP;
>     }
> 
>     finfo->flv_ops = fops;
> 
>     [...]
> }
> 
> parse_nla_flavors() is called in the control path so another check would not
> hit performance. I am more inclined to consider solution (ii).
> 
> What do you think?
> 
> > Thanks
> > Hangbin
> 
> Ciao,
> Andrea
