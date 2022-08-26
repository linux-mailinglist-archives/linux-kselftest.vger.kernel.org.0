Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8FD5A29F4
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 16:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344589AbiHZOrR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 10:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344591AbiHZOrD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 10:47:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049E9D8B25;
        Fri, 26 Aug 2022 07:46:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5297A61E6F;
        Fri, 26 Aug 2022 14:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F761C433D6;
        Fri, 26 Aug 2022 14:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661525218;
        bh=lSndhZ2rdlYCYSF4fsTiUalCAvFT7xxht3MoYvAbmAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XTy9Za+0gzR2PhxXOWTrsWMpqQzJfDzqOBQRhpkdKcMhol7PjnAUVgfDXR3ZtPve7
         vNhI9pi5HDLLwq+/NhZnNkKXyLEPqSwiYCc1Cf1WLXglToMXjzk2vHvR/bczAey18g
         j38me5SPTTpnVH4Hw3T02ymOapK2MBOwifELna+W+EsNKazytkdQpzek3Oq4h9+NRA
         sPeSsG3R/1cca24czOCNfOSRx6rS4tix+xbMRzfN1ps2SL/ZY18alJ60wX+YmHtKkM
         axCSiMuzeGJmO0YAUnzKiNk1pIq6Pryd+ZAYLydds2jvnfosyGhF/6XF1TTwNmSpw+
         aIqupDvKMSSWA==
Date:   Fri, 26 Aug 2022 17:46:51 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     roberto.sassu@huaweicloud.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel =?iso-8859-1?Q?M=FCller?= <deso@posteo.net>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH v12 02/10] btf: Handle dynamic pointer parameter in kfuncs
Message-ID: <Ywjc29EcrpbMObcd@kernel.org>
References: <20220818152929.402605-1-roberto.sassu@huaweicloud.com>
 <20220818152929.402605-3-roberto.sassu@huaweicloud.com>
 <YwhSCE0H+JfUe4Ew@kernel.org>
 <CAADnVQJbTzfe28ife1+vg+ByLfyLBTCoEZW_eg8TEw838JGaog@mail.gmail.com>
 <YwheJqUDLOxL3iTi@kernel.org>
 <YwjcItv0q8GdzPbb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwjcItv0q8GdzPbb@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 26, 2022 at 05:43:50PM +0300, Jarkko Sakkinen wrote:
> On Fri, Aug 26, 2022 at 08:46:14AM +0300, Jarkko Sakkinen wrote:
> > On Thu, Aug 25, 2022 at 10:16:14PM -0700, Alexei Starovoitov wrote:
> > > On Thu, Aug 25, 2022 at 9:54 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > > >
> > > > > -static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > > > > -                                  enum bpf_arg_type arg_type)
> > > > > +bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > > > > +                           enum bpf_arg_type arg_type)
> > > > >  {
> > > > >       struct bpf_func_state *state = func(env, reg);
> > > > >       int spi = get_spi(reg->off);
> > > > > --
> > > > > 2.25.1
> > > > >
> > > >
> > > > Might be niticking but generally I'd consider splitting
> > > > exports as commits of their own.
> > > 
> > > -static bool
> > > +bool
> > > 
> > > into a separate commit?
> > > 
> > > I guess it makes sense for people whose salary depends on
> > > number of commits.
> > > We don't play these games.
> > 
> > What kind of argument is that anyway.
> 
> "Separate each *logical change* into a separate patch." [*]
> 
> To add, generally any user space visible space should be an
                                           ~~~~~
                                           change

BR, Jarkko
