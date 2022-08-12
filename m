Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEA9590D36
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Aug 2022 10:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbiHLILE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Aug 2022 04:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiHLILE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Aug 2022 04:11:04 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882FE8285B;
        Fri, 12 Aug 2022 01:11:02 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M3xBL4ZtPz682wj;
        Fri, 12 Aug 2022 16:08:10 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 10:11:00 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Fri, 12 Aug 2022 10:11:00 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     =?iso-8859-1?Q?Daniel_M=FCller?= <deso@posteo.net>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Subject: RE: [PATCH v10 5/9] bpf: Add bpf_lookup_*_key() and bpf_key_put()
 kfuncs
Thread-Topic: [PATCH v10 5/9] bpf: Add bpf_lookup_*_key() and bpf_key_put()
 kfuncs
Thread-Index: AQHYrNrI3xbltKneMkianwQkzvowha2ohoeAgADLvDCAAEKEEIAAqsgAgACsYtA=
Date:   Fri, 12 Aug 2022 08:11:00 +0000
Message-ID: <bff9efc2121046d78e50f0a270d13dc3@huawei.com>
References: <20220810165932.2143413-1-roberto.sassu@huawei.com>
 <20220810165932.2143413-6-roberto.sassu@huawei.com>
 <20220810213351.wm5utltm67q4i6lu@MacBook-Pro-3.local.dhcp.thefacebook.com>
 <2415f4931a364541b2e6d14a8185ffbb@huawei.com>
 <f7d401d6ec6c47cbb358046a2d3ca5e8@huawei.com>
 <20220811235222.inghj73tf6vudoyw@vaio>
In-Reply-To: <20220811235222.inghj73tf6vudoyw@vaio>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.202.96]
Content-Type: text/plain; charset="iso-8859-1"
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

> From: Daniel Müller [mailto:deso@posteo.net]
> Sent: Friday, August 12, 2022 1:52 AM
> On Thu, Aug 11, 2022 at 12:02:57PM +0000, Roberto Sassu wrote:
> > > From: Roberto Sassu [mailto:roberto.sassu@huawei.com]
> > > Sent: Thursday, August 11, 2022 9:47 AM
> > > > From: Alexei Starovoitov [mailto:alexei.starovoitov@gmail.com]
> > > > Sent: Wednesday, August 10, 2022 11:34 PM
> > > > On Wed, Aug 10, 2022 at 06:59:28PM +0200, Roberto Sassu wrote:
> > > > > +
> > > > > +static int __init bpf_key_sig_kfuncs_init(void)
> > > > > +{
> > > > > +	int ret;
> > > > > +
> > > > > +	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
> > > > > +					&bpf_key_sig_kfunc_set);
> > > > > +	if (!ret)
> > > > > +		return 0;
> > > > > +
> > > > > +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
> > > > > +					 &bpf_key_sig_kfunc_set);
> > > >
> > > > Isn't this a watery water ?
> > > > Don't you have a patch 1 ?
> > > > What am I missing ?
> > >
> > > Uhm, yes. I had doubts too. That was what also KP did.
> > >
> > > It makes sense to register once, since we mapped LSM to
> > > TRACING.
> > >
> > > Will resend only this patch. And I will figure out why CI failed.
> >
> > Adding in CC Daniel Müller, which worked on this.
> >
> > I think the issue is that some kernel options are set to =m.
> > This causes the CI to miss all kernel modules, since they are
> > not copied to the virtual machine that executes the tests.
> >
> > I'm testing this patch:
> >
> > https://github.com/robertosassu/libbpf-
> ci/commit/b665e001b58c4ddb792a2a68098ea5dc6936b15c
> 
> I commented on the pull request. Would it make sense to adjust the
> kernel configuration in this repository instead? I am worried that
> otherwise everybody may need a similar work around, depending on how
> selftests are ultimately run.

The issue seems specific of the eBPF CI. Others might be able to use
kernel modules.

Either choice is fine for me.

Roberto
