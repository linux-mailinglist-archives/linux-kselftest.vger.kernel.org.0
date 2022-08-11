Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C164D58F88E
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Aug 2022 09:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbiHKHrB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Aug 2022 03:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiHKHq5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Aug 2022 03:46:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714C56FA35;
        Thu, 11 Aug 2022 00:46:56 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M3Jfz3Q4Mz67P5W;
        Thu, 11 Aug 2022 15:42:19 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 11 Aug 2022 09:46:53 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Thu, 11 Aug 2022 09:46:53 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
Thread-Index: AQHYrNrI3xbltKneMkianwQkzvowha2ohoeAgADLvDA=
Date:   Thu, 11 Aug 2022 07:46:53 +0000
Message-ID: <2415f4931a364541b2e6d14a8185ffbb@huawei.com>
References: <20220810165932.2143413-1-roberto.sassu@huawei.com>
 <20220810165932.2143413-6-roberto.sassu@huawei.com>
 <20220810213351.wm5utltm67q4i6lu@MacBook-Pro-3.local.dhcp.thefacebook.com>
In-Reply-To: <20220810213351.wm5utltm67q4i6lu@MacBook-Pro-3.local.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.209.212]
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

> From: Alexei Starovoitov [mailto:alexei.starovoitov@gmail.com]
> Sent: Wednesday, August 10, 2022 11:34 PM
> On Wed, Aug 10, 2022 at 06:59:28PM +0200, Roberto Sassu wrote:
> > +
> > +static int __init bpf_key_sig_kfuncs_init(void)
> > +{
> > +	int ret;
> > +
> > +	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
> > +					&bpf_key_sig_kfunc_set);
> > +	if (!ret)
> > +		return 0;
> > +
> > +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
> > +					 &bpf_key_sig_kfunc_set);
> 
> Isn't this a watery water ?
> Don't you have a patch 1 ?
> What am I missing ?

Uhm, yes. I had doubts too. That was what also KP did.

It makes sense to register once, since we mapped LSM to
TRACING.

Will resend only this patch. And I will figure out why CI failed.

Roberto
