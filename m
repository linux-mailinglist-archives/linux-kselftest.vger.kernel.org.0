Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBE15A7546
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 06:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiHaEv4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 00:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHaEvz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 00:51:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6CE65265;
        Tue, 30 Aug 2022 21:51:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34275B81EB1;
        Wed, 31 Aug 2022 04:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5224BC433C1;
        Wed, 31 Aug 2022 04:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661921511;
        bh=3hc0JiQ10+lioYj7fhQwiUGTwDaO7MDgbVhe9pyWLaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UR7cD6W9m1J8yFW2lOpqHOsVUIwgyN143uYYSvlf96bK49+EOKJ4saqvkGzRuhwAK
         HSvQiyMz14TIMQNp/MVmZbv6ImUtKy8j+wSvBul3m2pCyIpgGDXJ6LIS+soDbBecUK
         X0ZOCdcZd/OzLv5LtaRnEKnM7sA3GrPgvMEebB2SS02a3y6OjMOYPLIJMi/VAPTDar
         +Es4cCv7ovgM+qA0mFy8glTfkuPtELZ88/VK361HG3+erGIHdBgurm5UeESGZNPFxz
         I+GfHNRkAYr7mTYXJaG1ahoAQGpxLmrnN6Md0U4m1W4JsGS9gsGOfIpW9t9qIzOzwG
         VMRQqnv9Cp8Xw==
Date:   Wed, 31 Aug 2022 07:51:47 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        dhowells@redhat.com, rostedt@goodmis.org, mingo@redhat.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        shuah@kernel.org, bpf@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, memxor@gmail.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v14 05/12] KEYS: Move KEY_LOOKUP_ to include/linux/key.h
 and set KEY_LOOKUP_FLAGS_ALL
Message-ID: <Yw7o43Ivfo3jRwQg@kernel.org>
References: <20220830161716.754078-1-roberto.sassu@huaweicloud.com>
 <20220830161716.754078-6-roberto.sassu@huaweicloud.com>
 <Yw7NKJfhyJqIWUcx@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw7NKJfhyJqIWUcx@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 31, 2022 at 05:53:28AM +0300, Jarkko Sakkinen wrote:
> On Tue, Aug 30, 2022 at 06:17:09PM +0200, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > In preparation for the patch that introduces the bpf_lookup_user_key() eBPF
> > kfunc, move KEY_LOOKUP_ definitions to include/linux/key.h, to be able to
> > validate the kfunc parameters.
> > 
> > Also, define the new constant KEY_LOOKUP_FLAGS_ALL, to facilitate checking
> > whether a variable contains only defined flags.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Reviewed-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  include/linux/key.h      | 4 ++++
> >  security/keys/internal.h | 2 --
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/key.h b/include/linux/key.h
> > index 7febc4881363..e2a70e0fa89f 100644
> > --- a/include/linux/key.h
> > +++ b/include/linux/key.h
> > @@ -88,6 +88,10 @@ enum key_need_perm {
> >  	KEY_DEFER_PERM_CHECK,	/* Special: permission check is deferred */
> >  };
> >  
> > +#define KEY_LOOKUP_CREATE	0x01
> > +#define KEY_LOOKUP_PARTIAL	0x02
> > +#define KEY_LOOKUP_FLAGS_ALL	(KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL)
> 
> IMHO this could be just KEY_LOOKUP_ALL.
> 
> > +
> >  struct seq_file;
> >  struct user_struct;
> >  struct signal_struct;
> > diff --git a/security/keys/internal.h b/security/keys/internal.h
> > index 9b9cf3b6fcbb..3c1e7122076b 100644
> > --- a/security/keys/internal.h
> > +++ b/security/keys/internal.h
> > @@ -165,8 +165,6 @@ extern struct key *request_key_and_link(struct key_type *type,
> >  
> >  extern bool lookup_user_key_possessed(const struct key *key,
> >  				      const struct key_match_data *match_data);
> > -#define KEY_LOOKUP_CREATE	0x01
> > -#define KEY_LOOKUP_PARTIAL	0x02
> >  
> >  extern long join_session_keyring(const char *name);
> >  extern void key_change_session_keyring(struct callback_head *twork);
> > -- 
> > 2.25.1
> > 
> 
> Other than that wfm.

Roberto, with the change done above, just add my ack
to the next version:

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

