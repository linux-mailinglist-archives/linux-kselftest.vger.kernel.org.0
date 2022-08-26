Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566065A2C55
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 18:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiHZQdH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 12:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiHZQdG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 12:33:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B84D759A;
        Fri, 26 Aug 2022 09:33:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E236B8319C;
        Fri, 26 Aug 2022 16:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A48C433C1;
        Fri, 26 Aug 2022 16:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661531579;
        bh=dddAmdfWjVtoO1zNo5UFNAU20s8CfLCokEstVAbikEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uc453d6xrPO4sqirlR3Ea7botJQ14akx7wxI4nPJML+FKVFzSjHGdYhlpQMvjli+k
         mvdUbRjN/hizqNn+U0Ry37bYsjrOHblkP4YlVzZSffOt1Cw/KDqbh0Kk1yq0rgmsWm
         X5SedSOZTeS6ZL4nQf2M9BvLjwM2Se0R2gtBy3yxcVwiGVqsjpYkWrQH1treGXtfpv
         IgSOqICc92TmABZ0wDZnsFzBtU0Snly/E8a0nVgrdPc9Uo7UAvXcEfPqFVS3HxnNtu
         K9KU4kff5B9qMWIfir2e1QxPNKPNiTln0xnK5ciQuVad8bJ9E3urGaYhEWMQWQ904u
         3Janfpy2A5DvQ==
Date:   Fri, 26 Aug 2022 19:32:51 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <Ywj1s6d7XowV82PZ@kernel.org>
References: <20220818152929.402605-1-roberto.sassu@huaweicloud.com>
 <20220818152929.402605-3-roberto.sassu@huaweicloud.com>
 <YwhSCE0H+JfUe4Ew@kernel.org>
 <CAADnVQJbTzfe28ife1+vg+ByLfyLBTCoEZW_eg8TEw838JGaog@mail.gmail.com>
 <YwheJqUDLOxL3iTi@kernel.org>
 <YwjcItv0q8GdzPbb@kernel.org>
 <bb4bdd90017d5772bdc31dfac93f2e86c6c61b82.camel@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb4bdd90017d5772bdc31dfac93f2e86c6c61b82.camel@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 26, 2022 at 05:34:57PM +0200, Roberto Sassu wrote:
> On Fri, 2022-08-26 at 17:43 +0300, Jarkko Sakkinen wrote:
> > On Fri, Aug 26, 2022 at 08:46:14AM +0300, Jarkko Sakkinen wrote:
> > > On Thu, Aug 25, 2022 at 10:16:14PM -0700, Alexei Starovoitov wrote:
> > > > On Thu, Aug 25, 2022 at 9:54 PM Jarkko Sakkinen <
> > > > jarkko@kernel.org> wrote:
> > > > > > -static bool is_dynptr_reg_valid_init(struct bpf_verifier_env
> > > > > > *env, struct bpf_reg_state *reg,
> > > > > > -                                  enum bpf_arg_type
> > > > > > arg_type)
> > > > > > +bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
> > > > > > struct bpf_reg_state *reg,
> > > > > > +                           enum bpf_arg_type arg_type)
> > > > > >  {
> > > > > >       struct bpf_func_state *state = func(env, reg);
> > > > > >       int spi = get_spi(reg->off);
> > > > > > --
> > > > > > 2.25.1
> > > > > > 
> > > > > 
> > > > > Might be niticking but generally I'd consider splitting
> > > > > exports as commits of their own.
> > > > 
> > > > -static bool
> > > > +bool
> > > > 
> > > > into a separate commit?
> > > > 
> > > > I guess it makes sense for people whose salary depends on
> > > > number of commits.
> > > > We don't play these games.
> > > 
> > > What kind of argument is that anyway.
> > 
> > "Separate each *logical change* into a separate patch." [*]
> 
> The logical change, as per the patch subject, is allowing the
> possibility of including eBPF dynamic pointers in a kfunc definition.
> It requires to call an existing function that was already defined
> elsewhere.
> 
> Maybe I'm wrong, but I don't see only exporting a function definition
> to an include file as a logical change. To me, the changes in this
> patch are clearly connected. Or even better, they tell why the function
> definition has been exported, that would not appear if moving the
> function definition is a standalone patch.
> 
> > 
> > To add, generally any user space visible space should be an
> > isolated patch.
> 
> As far as I understood, definitions visible to user space should be in
> include/uapi.

It does change e.g. the output of kallsyms.

It's not ABI but it's still user space visble.

> 
> > 
> > Please, stop posting nonsense.
> 
> If I may, saying this does not encourage people to try to submit their
> code. I feel it is a bit strong, and I kindly ask you to express your
> opinion in a more gentle way.

I agree. That's why I was wondering what is this nonsense
about salary and games.

BR, Jarkko
