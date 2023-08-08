Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDE9773B3A
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 17:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjHHPqn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 11:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHHPpK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 11:45:10 -0400
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.6.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353753A98;
        Tue,  8 Aug 2023 08:40:37 -0700 (PDT)
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
        by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 378Dq6vp018430;
        Tue, 8 Aug 2023 15:52:13 +0200
Received: from lubuntu-18.04 (unknown [160.80.103.126])
        by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 47D7A1208B1;
        Tue,  8 Aug 2023 15:52:02 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
        s=ed201904; t=1691502722; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZYJ2Hbc6jQGJN61PVddVdQYgnFTt3pXorVwXhXM9k0w=;
        b=dFaSqe5C6cG5BeVyTeXP0E+57SwBzb9/aX0Ui4GDgADgSrlfQee5GMOG9j/9aVNMzmKBb0
        5rp66vkqjBRFBdBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
        t=1691502722; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZYJ2Hbc6jQGJN61PVddVdQYgnFTt3pXorVwXhXM9k0w=;
        b=NJJzP625Sm/qY8uuK5i+R5ihru0V0zf7NB0bVCHU1KZSlMuN9hgPbtMy8NaqPpfWy+Zr0Y
        dCO82WwDHF182M7aeEV5h9d0Z8TZBCsqMD7WfATeFfQDs0iZ8is3Gfx6pWFpbZ/KqJSouQ
        AWHAHab+fbzEPZDDc3ysNFb7DTcE8b2Lo4FJojR7YgM7AmdkkDGwC25oo3TjPQ/9JcSaNj
        n0VwS9k5K2A/E6lONczelVK7WgOrniQp/l6OydXESXV7N5WbjN7fZ/Rv7SysARYbvLHJT9
        fUbz3Qp3a5t/ooH2ej0uAkEa1paYxztDEj+2DA4KWri+vfByCM2vbVwivtbzoQ==
Date:   Tue, 8 Aug 2023 15:52:01 +0200
From:   Andrea Mayer <andrea.mayer@uniroma2.it>
To:     Hangbin Liu <liuhangbin@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels.dev@gmail.com>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [net-next 1/2] seg6: add NEXT-C-SID support for SRv6 End.X
 behavior
Message-Id: <20230808155201.d80cead76984031211da396b@uniroma2.it>
In-Reply-To: <ZM4Ff0Rk2SBiDdC0@Laptop-X1>
References: <20230731175117.17376-1-andrea.mayer@uniroma2.it>
        <20230731175117.17376-2-andrea.mayer@uniroma2.it>
        <ZMtztGiOWV6bqCLg@Laptop-X1>
        <20230804144118.a52808dc5fecda09751fae9d@uniroma2.it>
        <ZM4Ff0Rk2SBiDdC0@Laptop-X1>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 5 Aug 2023 16:17:03 +0800
Hangbin Liu <liuhangbin@gmail.com> wrote:

> On Fri, Aug 04, 2023 at 02:41:18PM +0200, Andrea Mayer wrote:
> > Hi Hangbin,
> > thanks for your time. Please see below.
> > 
> > On Thu, 3 Aug 2023 17:30:28 +0800
> > Hangbin Liu <liuhangbin@gmail.com> wrote:
> > 
> > > On Mon, Jul 31, 2023 at 07:51:16PM +0200, Andrea Mayer wrote:
> > > > +/* Processing of SRv6 End, End.X, and End.T behaviors can be extended through
> > > > + * the flavors framework. These behaviors must report the subset of (flavor)
> > > > + * operations they currently implement. In this way, if a user specifies a
> > > > + * flavor combination that is not supported by a given End* behavior, the
> > > > + * kernel refuses to instantiate the tunnel reporting the error.
> > > > + */
> > > > +static int seg6_flv_supp_ops_by_action(int action, __u32 *fops)
> > > > +{
> > > > +	switch (action) {
> > > > +	case SEG6_LOCAL_ACTION_END:
> > > > +		*fops = SEG6_LOCAL_END_FLV_SUPP_OPS;
> > > > +		break;
> > > > +	case SEG6_LOCAL_ACTION_END_X:
> > > > +		*fops = SEG6_LOCAL_END_X_FLV_SUPP_OPS;
> > > > +		break;
> > > > +	default:
> > > > +		return -EOPNOTSUPP;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > >  }
> > > >  
> > > 
> > > ...
> > > 
> > > > @@ -2070,7 +2131,8 @@ static int parse_nla_flavors(struct nlattr **attrs, struct seg6_local_lwt *slwt,
> > > >  {
> > > >  	struct seg6_flavors_info *finfo = &slwt->flv_info;
> > > >  	struct nlattr *tb[SEG6_LOCAL_FLV_MAX + 1];
> > > > -	unsigned long fops;
> > > > +	int action = slwt->action;
> > > > +	__u32 fops, supp_fops = 0;
> > > >  	int rc;
> > > >  
> > > >  	rc = nla_parse_nested_deprecated(tb, SEG6_LOCAL_FLV_MAX,
> > > > @@ -2086,7 +2148,8 @@ static int parse_nla_flavors(struct nlattr **attrs, struct seg6_local_lwt *slwt,
> > > >  		return -EINVAL;
> > > >  
> > > >  	fops = nla_get_u32(tb[SEG6_LOCAL_FLV_OPERATION]);
> > > > -	if (fops & ~SEG6_LOCAL_FLV_SUPP_OPS) {
> > > > +	rc = seg6_flv_supp_ops_by_action(action, &supp_fops);
> > > > +	if (rc < 0 || !supp_fops || (fops & ~supp_fops)) {
> > > 
> > > if rc == 0, the supp_fops won't be 0.
> > > 
> > 
> > Yes, you're right.
> > 
> > In this patch, supp_fops is always set properly when rc == 0.
> > Since seg6_flv_supp_ops_by_action() should be extended in the event that other
> > behaviors receive flavors support, I added this check in case the "supp_fops"
> > field was set incorrectly or not set at all.
> > Note that supp_fops == 0 must be considered an inadmissible value.
> > 
> > 
> > So, I think we have two possibilities:
> >   i) remove this "defensive" check, assuming that supp_fops will always be set
> >      correctly by seg6_flv_supp_ops_by_action() (when rc == 0, like in this
> >      patch); 
> >  ii) improve the check by explicitly indicating with a pr_warn_once, for
> >      example, the condition that is occurring is unexpected.
> > 
> > for (ii), something like this:
> > 
> > parse_nla_flavors(...)
> > {
> >     [...]
> >     supp_fops = 0;
> >     [...]
> > 
> >     rc = seg6_flv_supp_ops_by_action(action, &supp_fops);
> >     if (!rc && !supp_fops) {
> >    	 /* supported flavors mask cannot be zero as it is considered to
> >    	  * be invalid.
> >    	  */
> >    	 pr_warn_once("seg6local: invalid Flavor operation(s)");
> >    	 return -EINVAL;
> >     }
> 
> Do you mean there is a possibility *in future* that the supp_fops could be 0
> with rc == 0? If yes, this check would make sense(although we can add this
> check when it's true). If not. I don't see a need to have this check.
> 
> And some static analysis tool would report warn for this code.
> 

Good points, thanks.
There is no possibility at the moment that supp_fops could be 0 with rc == 0.
That check is going to be removed in v2.

> Thanks
> Hangbin

Ciao,
Andrea

> > 
> >     fops = nla_get_u32(tb[SEG6_LOCAL_FLV_OPERATION]);
> >     if (rc < 0 || (fops & ~supp_fops)) {
> >    	 NL_SET_ERR_MSG(extack, "Unsupported Flavor operation(s)");
> >    	 return -EOPNOTSUPP;
> >     }
> > 
> >     finfo->flv_ops = fops;
> > 
> >     [...]
> > }
> > 
> > parse_nla_flavors() is called in the control path so another check would not
> > hit performance. I am more inclined to consider solution (ii).
> > 
> > What do you think?
> > 
> > > Thanks
> > > Hangbin
> > 
> > Ciao,
> > Andrea
