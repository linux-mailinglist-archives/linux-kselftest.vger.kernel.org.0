Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6FB5A7A13
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 11:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiHaJW4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 05:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiHaJWz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 05:22:55 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4C0BE0B;
        Wed, 31 Aug 2022 02:22:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4MHdqS5Q52z9v7Yy;
        Wed, 31 Aug 2022 17:17:24 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDnY15BKA9j0y0QAA--.24163S2;
        Wed, 31 Aug 2022 10:22:22 +0100 (CET)
Message-ID: <e3c7321ed035f00e8e70f832915065ea67d9ef3b.camel@huaweicloud.com>
Subject: Re: [PATCH v14 02/12] bpf: Move dynptr type check to
 is_dynptr_type_expected()
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        dhowells@redhat.com, jarkko@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org, bpf@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, memxor@gmail.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 31 Aug 2022 11:22:05 +0200
In-Reply-To: <CAJnrk1bL2MSN81ORrkm9JcFQh3qsJ1jVGXEycSjyhk+Jv_Bz2Q@mail.gmail.com>
References: <20220830161716.754078-1-roberto.sassu@huaweicloud.com>
         <20220830161716.754078-3-roberto.sassu@huaweicloud.com>
         <CAJnrk1bL2MSN81ORrkm9JcFQh3qsJ1jVGXEycSjyhk+Jv_Bz2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwDnY15BKA9j0y0QAA--.24163S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XFyxKw4xAFy5AF15XF4fKrg_yoW7AFWUpa
        n7GayUXF4ktF42vw17tF4DAFy5KrW8WrWrCrZYva40yFn7Zr9xZF15Kr17Wr9YkFyDCw4f
        Z340vFZ8Zw15AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgABBF1jj3515gABsa
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2022-08-30 at 09:46 -0700, Joanne Koong wrote:
> On Tue, Aug 30, 2022 at 9:18 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Move dynptr type check to is_dynptr_type_expected() from
> > is_dynptr_reg_valid_init(), so that callers can better determine
> > the cause
> > of a negative result (dynamic pointer not valid/initialized,
> > dynamic
> > pointer of the wrong type).
> > 
> > Also, splitting makes the code more readable, since checking the
> > dynamic
> > pointer type is not necessarily related to validity and
> > initialization.
> 
> I think it'd be helpful to also include that btf will be using these
> functions, which seems like the main motivation behind why this
> change
> is needed.

Ok, added.

> > Split the validity/initialization and dynamic pointer type check
> > also in
> > the verifier, and adjust the expected error message in the test (a
> > test for
> > an unexpected dynptr type passed to a helper cannot be added due to
> > missing
> > suitable helpers, but this case has been tested manually).
> 
> The bpf_ringbuf_submit_dynptr() and bpf_ringbuf_discard_dynptr()
> helpers take in only ringbuf-type dynptrs, so either of these would
> work for testing the case where an incorrect dynptr type is passed in
> :)

Uhm, that didn't work.

If I initialize a local dynptr, and call bpf_ringbuf_submit_dynptr(), I
get:

arg 1 is an unacquired reference

The only way to make this work was to create a custom helper, with
OBJ_RELEASE removed.

> > Cc: Joanne Koong <joannelkoong@gmail.com>
> > Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  kernel/bpf/verifier.c                         | 35 ++++++++++++++-
> > ----
> >  .../testing/selftests/bpf/prog_tests/dynptr.c |  2 +-
> >  2 files changed, 28 insertions(+), 9 deletions(-)
> > 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 0194a36d0b36..1b913db252a3 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -779,8 +779,8 @@ static bool is_dynptr_reg_valid_uninit(struct
> > bpf_verifier_env *env, struct bpf_
> >         return true;
> >  }
> > 
> > -static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
> > struct bpf_reg_state *reg,
> > -                                    enum bpf_arg_type arg_type)
> > +static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
> > +                                    struct bpf_reg_state *reg)
> >  {
> >         struct bpf_func_state *state = func(env, reg);
> >         int spi = get_spi(reg->off);
> > @@ -796,11 +796,24 @@ static bool is_dynptr_reg_valid_init(struct
> > bpf_verifier_env *env, struct bpf_re
> >                         return false;
> >         }
> > 
> > +       return true;
> > +}
> > +
> > +static bool is_dynptr_type_expected(struct bpf_verifier_env *env,
> > +                                   struct bpf_reg_state *reg,
> > +                                   enum bpf_arg_type arg_type)
> > +{
> > +       struct bpf_func_state *state = func(env, reg);
> > +       int spi = get_spi(reg->off);
> > +       enum bpf_dynptr_type dynptr_type;
> 
> nit: the above 2 lines should be swapped to maintain reverse
> christmas
> tree order of declarations

Ok.

Thanks

Roberto

> 
> > +
> >         /* ARG_PTR_TO_DYNPTR takes any type of dynptr */
> >         if (arg_type == ARG_PTR_TO_DYNPTR)
> >                 return true;
> > 
> > -       return state->stack[spi].spilled_ptr.dynptr.type ==
> > arg_to_dynptr_type(arg_type);
> > +       dynptr_type = arg_to_dynptr_type(arg_type);
> > +
> > +       return state->stack[spi].spilled_ptr.dynptr.type ==
> > dynptr_type;
> >  }
> > 
> >  /* The reg state of a pointer or a bounded scalar was saved when
> > @@ -6050,21 +6063,27 @@ static int check_func_arg(struct
> > bpf_verifier_env *env, u32 arg,
> >                         }
> > 
> >                         meta->uninit_dynptr_regno = regno;
> > -               } else if (!is_dynptr_reg_valid_init(env, reg,
> > arg_type)) {
> > +               } else if (!is_dynptr_reg_valid_init(env, reg)) {
> > +                       verbose(env,
> > +                               "Expected an initialized dynptr as
> > arg #%d\n",
> > +                               arg + 1);
> > +                       return -EINVAL;
> > +               } else if (!is_dynptr_type_expected(env, reg,
> > arg_type)) {
> >                         const char *err_extra = "";
> > 
> >                         switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
> >                         case DYNPTR_TYPE_LOCAL:
> > -                               err_extra = "local ";
> > +                               err_extra = "local";
> >                                 break;
> >                         case DYNPTR_TYPE_RINGBUF:
> > -                               err_extra = "ringbuf ";
> > +                               err_extra = "ringbuf";
> >                                 break;
> >                         default:
> > +                               err_extra = "<unknown>";
> >                                 break;
> >                         }
> > -
> > -                       verbose(env, "Expected an initialized
> > %sdynptr as arg #%d\n",
> > +                       verbose(env,
> > +                               "Expected a dynptr of type %s as
> > arg #%d\n",
> >                                 err_extra, arg + 1);
> >                         return -EINVAL;
> >                 }
> > diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c
> > b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> > index bcf80b9f7c27..8fc4e6c02bfd 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> > @@ -30,7 +30,7 @@ static struct {
> >         {"invalid_helper2", "Expected an initialized dynptr as arg
> > #3"},
> >         {"invalid_write1", "Expected an initialized dynptr as arg
> > #1"},
> >         {"invalid_write2", "Expected an initialized dynptr as arg
> > #3"},
> > -       {"invalid_write3", "Expected an initialized ringbuf dynptr
> > as arg #1"},
> > +       {"invalid_write3", "Expected an initialized dynptr as arg
> > #1"},
> >         {"invalid_write4", "arg 1 is an unacquired reference"},
> >         {"invalid_read1", "invalid read from stack"},
> >         {"invalid_read2", "cannot pass in dynptr at an offset"},
> > --
> > 2.25.1
> > 

