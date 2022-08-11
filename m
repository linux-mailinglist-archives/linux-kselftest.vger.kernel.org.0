Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E3959095F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Aug 2022 01:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbiHKXyX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Aug 2022 19:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbiHKXyU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Aug 2022 19:54:20 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F51A1D45
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Aug 2022 16:54:18 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 9ECDF240107
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Aug 2022 01:54:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1660262056; bh=JkMK2ZzPPyQl8oBskpaCW68aHa6Y2QAApaUOJCrkky0=;
        h=Date:From:To:Cc:Subject:From;
        b=NhFylEAcYSP6ooajuZO4T2YGW5fL5ATOhgbkDJooGFyAbZTbVwTZnX5pApklMyoSF
         Aap+nYNKvCfvx9nZRlcKWt2CvEm/dN0ajORKOl6OqcT8Yxh6ZuWlD5+W+Gc3Fm6f+B
         LMKIFBWuqLyW43a3noOsHPkh5P8CzorGxYoYPkEUGtvLchkv70K8nzJuhZKeodw6jG
         LQ4mNGo/BVKiMFMvD8jxUH5xJCpw6RDbYMH98HcgdlQaSrer9xPQGHJ3R3xrGS75ec
         Yw0kyhs1pYpcO6zPr4fU8xKEbf9ueKqkuD2FYp76ICzCIDq4S1XRVN6N6Rfs0wZY5C
         DI/hfLUca7cYQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4M3kDF2Dxrz6tm9;
        Fri, 12 Aug 2022 01:54:04 +0200 (CEST)
Date:   Thu, 11 Aug 2022 23:52:22 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
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
        "jarkko@kernel.org" <jarkko@kernel.org>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 5/9] bpf: Add bpf_lookup_*_key() and bpf_key_put()
 kfuncs
Message-ID: <20220811235222.inghj73tf6vudoyw@vaio>
References: <20220810165932.2143413-1-roberto.sassu@huawei.com>
 <20220810165932.2143413-6-roberto.sassu@huawei.com>
 <20220810213351.wm5utltm67q4i6lu@MacBook-Pro-3.local.dhcp.thefacebook.com>
 <2415f4931a364541b2e6d14a8185ffbb@huawei.com>
 <f7d401d6ec6c47cbb358046a2d3ca5e8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7d401d6ec6c47cbb358046a2d3ca5e8@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 11, 2022 at 12:02:57PM +0000, Roberto Sassu wrote:
> > From: Roberto Sassu [mailto:roberto.sassu@huawei.com]
> > Sent: Thursday, August 11, 2022 9:47 AM
> > > From: Alexei Starovoitov [mailto:alexei.starovoitov@gmail.com]
> > > Sent: Wednesday, August 10, 2022 11:34 PM
> > > On Wed, Aug 10, 2022 at 06:59:28PM +0200, Roberto Sassu wrote:
> > > > +
> > > > +static int __init bpf_key_sig_kfuncs_init(void)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
> > > > +					&bpf_key_sig_kfunc_set);
> > > > +	if (!ret)
> > > > +		return 0;
> > > > +
> > > > +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
> > > > +					 &bpf_key_sig_kfunc_set);
> > >
> > > Isn't this a watery water ?
> > > Don't you have a patch 1 ?
> > > What am I missing ?
> > 
> > Uhm, yes. I had doubts too. That was what also KP did.
> > 
> > It makes sense to register once, since we mapped LSM to
> > TRACING.
> > 
> > Will resend only this patch. And I will figure out why CI failed.
> 
> Adding in CC Daniel Müller, which worked on this.
> 
> I think the issue is that some kernel options are set to =m.
> This causes the CI to miss all kernel modules, since they are
> not copied to the virtual machine that executes the tests.
> 
> I'm testing this patch:
> 
> https://github.com/robertosassu/libbpf-ci/commit/b665e001b58c4ddb792a2a68098ea5dc6936b15c

I commented on the pull request. Would it make sense to adjust the
kernel configuration in this repository instead? I am worried that
otherwise everybody may need a similar work around, depending on how
selftests are ultimately run.

Thanks,
Daniel
