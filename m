Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23635A3B40
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Aug 2022 05:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiH1D5x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Aug 2022 23:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiH1D5w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Aug 2022 23:57:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC89D2E9ED;
        Sat, 27 Aug 2022 20:57:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B675B80782;
        Sun, 28 Aug 2022 03:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43E1C433D6;
        Sun, 28 Aug 2022 03:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661659069;
        bh=aLxP25wDWEInIvXhlH9j51/2YWETEUidD0n/OTr2pK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZWNzKiOyT21V4JyykeIWDNlktUtVvAV3qdLPCvmMWyytyA5VHrqjNKDxLu252/8TM
         XwKUJ+iyP9uImOcVcNzIiITHKtVYzwZn2cZxJ56AJFihKNPA/YaT8p0drsQsVjeyik
         BFDRUHeU+8Dx+uA/myfFJDPL+6X5CHlZh1244NN5JjHEsldxtkSU8eNRwt8Hhxi+Nj
         ofVVe0zdAxL8vKra2UO9R8NsKsqQQosYmRYbSAkSzNULPnhiWJ70xRucftOwK3e2PL
         /t/DFAAMSl1I85SeFR+ip+6BKCBa8x1hQiJNehG1ISDYZVlkkUNKsG8GxHQsboIiAP
         sCNLzPdbYwyUw==
Date:   Sun, 28 Aug 2022 06:57:41 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        corbet@lwn.net, dhowells@redhat.com, rostedt@goodmis.org,
        mingo@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v12 04/10] KEYS: Move KEY_LOOKUP_ to include/linux/key.h
Message-ID: <YwrntbSJUs2cA7Xn@kernel.org>
References: <20220818152929.402605-1-roberto.sassu@huaweicloud.com>
 <20220818152929.402605-5-roberto.sassu@huaweicloud.com>
 <YwhTiGOhzvv+CYYq@kernel.org>
 <acae432697e854748d9a44c732ec8cab807d9d46.camel@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acae432697e854748d9a44c732ec8cab807d9d46.camel@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 26, 2022 at 09:14:09AM +0200, Roberto Sassu wrote:
> On Fri, 2022-08-26 at 08:42 +0300, Jarkko Sakkinen wrote:
> > On Thu, Aug 18, 2022 at 05:29:23PM +0200, 
> > roberto.sassu@huaweicloud.com wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > In preparation for the patch that introduces the
> > > bpf_lookup_user_key() eBPF
> > > kfunc, move KEY_LOOKUP_ definitions to include/linux/key.h, to be
> > > able to
> > > validate the kfunc parameters.
> > > 
> > > Also, introduce key_lookup_flags_check() directly in
> > > include/linux/key.h,
> > > to reduce the risk that the check is not in sync with currently
> > > defined
> > > flags.
> > 
> > Missing the description what the heck this function even is.
> > 
> > Please, explain that.
> 
> Hi Jarkko
> 
> sorry, forgot to update the commit description. Will do it.
> 
> > Also, the short subject is misleading because this *just*
> > does not move flags.
> > 
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Reviewed-by: KP Singh <kpsingh@kernel.org>
> > > ---
> > >  include/linux/key.h      | 11 +++++++++++
> > >  security/keys/internal.h |  2 --
> > >  2 files changed, 11 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/linux/key.h b/include/linux/key.h
> > > index 7febc4881363..b5bbae77a9e7 100644
> > > --- a/include/linux/key.h
> > > +++ b/include/linux/key.h
> > > @@ -88,6 +88,17 @@ enum key_need_perm {
> > >  	KEY_DEFER_PERM_CHECK,	/* Special: permission check is
> > > deferred */
> > >  };
> > >  
> > > +#define KEY_LOOKUP_CREATE	0x01
> > > +#define KEY_LOOKUP_PARTIAL	0x02
> > > +
> > 
> > /*
> >  * Explain what the heck this function is.
> >  */
> > > +static inline int key_lookup_flags_check(u64 flags)
> > > +{
> > > +	if (flags & ~(KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL))
> > > +		return -EINVAL;
> > > +
> > > +	return 0;
> > > +}
> > 
> > This is essentially a boolean function, right?
> > 
> > I.e. the implementation can be just:
> > 
> > !!(flags & ~(KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL))
> 
> Absolutely fine with that, if you prefer.

It can be either, it more depends on if a new function
is needed in the first place.

E.g. if you are worried about maintaining you could just
as well define a constant containing the mask, right?

> 
> > Not even sure if this is needed in the first place, or
> > would it be better just to open code it. How many call
> > sites does it have anyway?
> > 
> 
> Daniel preferred to have this check here.

How many call sites?

BR, Jarkko
