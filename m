Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1ED58ED87
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Aug 2022 15:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbiHJNoe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Aug 2022 09:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiHJNod (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Aug 2022 09:44:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27876714A;
        Wed, 10 Aug 2022 06:44:31 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M2rh82TQLz67wDW;
        Wed, 10 Aug 2022 21:41:44 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 10 Aug 2022 15:44:29 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Wed, 10 Aug 2022 15:44:29 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "sdf@google.com" <sdf@google.com>,
        "haoluo@google.com" <haoluo@google.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: RE: [PATCH v9 01/10] btf: Add a new kfunc flag which allows to mark a
 function to be sleepable
Thread-Topic: [PATCH v9 01/10] btf: Add a new kfunc flag which allows to mark
 a function to be sleepable
Thread-Index: AQHYq/aDa3kCDLsk5EK6T80CaXl/sK2mqA6AgAF8nfA=
Date:   Wed, 10 Aug 2022 13:44:28 +0000
Message-ID: <c9e73d7aa51a47c585b935a41dbf1924@huawei.com>
References: <20220809134603.1769279-1-roberto.sassu@huawei.com>
 <20220809134603.1769279-2-roberto.sassu@huawei.com>
 <YvKRYRjJdXbAWL6Y@kernel.org>
In-Reply-To: <YvKRYRjJdXbAWL6Y@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.45.144.193]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jarkko Sakkinen [mailto:jarkko@kernel.org]
> Sent: Tuesday, August 9, 2022 6:55 PM
> On Tue, Aug 09, 2022 at 03:45:54PM +0200, Roberto Sassu wrote:
> > From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > This allows to declare a kfunc as sleepable and prevents its use in
> > a non sleepable program.
> 
> Nit: "Declare a kfunc as sleepable and prevent its use in a
> non-sleepable program."
> 
> It's missing the part *how* the patch accomplishes its goals.

I will add:

If an eBPF program is going to call a kfunc declared as sleepable,
eBPF will look at the eBPF program flags. If BPF_F_SLEEPABLE is
not set, execution of that program is denied.

Roberto

> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > Co-developed-by: Yosry Ahmed <yosryahmed@google.com>
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > Signed-off-by: Hao Luo <haoluo@google.com>
> > ---
> >  Documentation/bpf/kfuncs.rst | 6 ++++++
> >  include/linux/btf.h          | 1 +
> >  kernel/bpf/btf.c             | 9 +++++++++
> >  3 files changed, 16 insertions(+)
> >
> > diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> > index c0b7dae6dbf5..c8b21de1c772 100644
> > --- a/Documentation/bpf/kfuncs.rst
> > +++ b/Documentation/bpf/kfuncs.rst
> > @@ -146,6 +146,12 @@ that operate (change some property, perform some
> operation) on an object that
> >  was obtained using an acquire kfunc. Such kfuncs need an unchanged pointer
> to
> >  ensure the integrity of the operation being performed on the expected object.
> >
> > +2.4.6 KF_SLEEPABLE flag
> > +-----------------------
> > +
> > +The KF_SLEEPABLE flag is used for kfuncs that may sleep. Such kfuncs can
> only
> > +be called by sleepable BPF programs (BPF_F_SLEEPABLE).
> > +
> >  2.5 Registering the kfuncs
> >  --------------------------
> >
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index cdb376d53238..976cbdd2981f 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -49,6 +49,7 @@
> >   * for this case.
> >   */
> >  #define KF_TRUSTED_ARGS (1 << 4) /* kfunc only takes trusted pointer
> arguments */
> > +#define KF_SLEEPABLE   (1 << 5) /* kfunc may sleep */
> >
> >  struct btf;
> >  struct btf_member;
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 7e64447659f3..d3e4c86b8fcd 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6175,6 +6175,7 @@ static int btf_check_func_arg_match(struct
> bpf_verifier_env *env,
> >  {
> >  	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
> >  	bool rel = false, kptr_get = false, trusted_arg = false;
> > +	bool sleepable = false;
> >  	struct bpf_verifier_log *log = &env->log;
> >  	u32 i, nargs, ref_id, ref_obj_id = 0;
> >  	bool is_kfunc = btf_is_kernel(btf);
> > @@ -6212,6 +6213,7 @@ static int btf_check_func_arg_match(struct
> bpf_verifier_env *env,
> >  		rel = kfunc_flags & KF_RELEASE;
> >  		kptr_get = kfunc_flags & KF_KPTR_GET;
> >  		trusted_arg = kfunc_flags & KF_TRUSTED_ARGS;
> > +		sleepable = kfunc_flags & KF_SLEEPABLE;
> >  	}
> >
> >  	/* check that BTF function arguments match actual types that the
> > @@ -6419,6 +6421,13 @@ static int btf_check_func_arg_match(struct
> bpf_verifier_env *env,
> >  			func_name);
> >  		return -EINVAL;
> >  	}
> > +
> > +	if (sleepable && !env->prog->aux->sleepable) {
> > +		bpf_log(log, "kernel function %s is sleepable but the program is
> not\n",
> > +			func_name);
> > +		return -EINVAL;
> > +	}
> > +
> >  	/* returns argument register number > 0 in case of reference release
> kfunc */
> >  	return rel ? ref_regno : 0;
> >  }
> > --
> > 2.25.1
> >
> 
> BR, Jarkko
