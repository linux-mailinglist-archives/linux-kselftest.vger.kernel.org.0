Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3161E5A2B59
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 17:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344094AbiHZPf6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 11:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243036AbiHZPfw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 11:35:52 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9263131ECD;
        Fri, 26 Aug 2022 08:35:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4MDkMv6kHZz9xFm3;
        Fri, 26 Aug 2022 23:31:55 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAHJREl6AhjIoFPAA--.24624S2;
        Fri, 26 Aug 2022 16:35:16 +0100 (CET)
Message-ID: <bb4bdd90017d5772bdc31dfac93f2e86c6c61b82.camel@huaweicloud.com>
Subject: Re: [PATCH v12 02/10] btf: Handle dynamic pointer parameter in
 kfuncs
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
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
        Daniel =?ISO-8859-1?Q?M=FCller?= <deso@posteo.net>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Joanne Koong <joannelkoong@gmail.com>
Date:   Fri, 26 Aug 2022 17:34:57 +0200
In-Reply-To: <YwjcItv0q8GdzPbb@kernel.org>
References: <20220818152929.402605-1-roberto.sassu@huaweicloud.com>
         <20220818152929.402605-3-roberto.sassu@huaweicloud.com>
         <YwhSCE0H+JfUe4Ew@kernel.org>
         <CAADnVQJbTzfe28ife1+vg+ByLfyLBTCoEZW_eg8TEw838JGaog@mail.gmail.com>
         <YwheJqUDLOxL3iTi@kernel.org> <YwjcItv0q8GdzPbb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwAHJREl6AhjIoFPAA--.24624S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KrWUCrW8JF18Xw17JF45Awb_yoW8ZFyDpa
        ykAa9Fkr4UJr45CwnFqF4FyFnavr1Fqr1kury5J34FvFyqgrnFgFs2qw1Yka45Gr4kCF18
        Xa10qry7X3W5AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAQBF1jj4JUwgAAsw
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2022-08-26 at 17:43 +0300, Jarkko Sakkinen wrote:
> On Fri, Aug 26, 2022 at 08:46:14AM +0300, Jarkko Sakkinen wrote:
> > On Thu, Aug 25, 2022 at 10:16:14PM -0700, Alexei Starovoitov wrote:
> > > On Thu, Aug 25, 2022 at 9:54 PM Jarkko Sakkinen <
> > > jarkko@kernel.org> wrote:
> > > > > -static bool is_dynptr_reg_valid_init(struct bpf_verifier_env
> > > > > *env, struct bpf_reg_state *reg,
> > > > > -                                  enum bpf_arg_type
> > > > > arg_type)
> > > > > +bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
> > > > > struct bpf_reg_state *reg,
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

The logical change, as per the patch subject, is allowing the
possibility of including eBPF dynamic pointers in a kfunc definition.
It requires to call an existing function that was already defined
elsewhere.

Maybe I'm wrong, but I don't see only exporting a function definition
to an include file as a logical change. To me, the changes in this
patch are clearly connected. Or even better, they tell why the function
definition has been exported, that would not appear if moving the
function definition is a standalone patch.

> 
> To add, generally any user space visible space should be an
> isolated patch.

As far as I understood, definitions visible to user space should be in
include/uapi.

> 
> Please, stop posting nonsense.

If I may, saying this does not encourage people to try to submit their
code. I feel it is a bit strong, and I kindly ask you to express your
opinion in a more gentle way.

Thanks

Roberto

