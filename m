Return-Path: <linux-kselftest+bounces-10088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4085C8C2E7C
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 03:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5929BB224A3
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 01:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE091172C;
	Sat, 11 May 2024 01:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPI+OgTg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B75B8C13;
	Sat, 11 May 2024 01:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715391762; cv=none; b=adsZB4ZGYucLSIBtSF2SYyjempEXWNb90j7QFMOBG8rwldHm4Cbe0o1sk4M9lbzv4yzyIjcVg2eEQRmfKG+0EgBG4rvYCvLfebDrJH3xwZLnZSvRRE/Auh0zwOO4pI9dFupWRfXyK6RCThwVB4Cvu2Y6HmCy0qsfr1pOg/zQXxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715391762; c=relaxed/simple;
	bh=B98QXwaMAkRfgO2gYmiRCq3L4jfQpvnIuCNjwrmLHLM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rjz7FQ1cqclUvD4C/nakIEHQrFddFROJlPME+N3UjGebc95DeCyS3s04OaWgg7fL/1DU9kBPchlyjkJMBnK1sm3bH2G9kLi08b8Rj+/lzYtw5FUfY0eKhpmWU0X4EbJWRu1efIT+ZQeUCRSktxSvHWtRboqvMYj3trRN83ayqgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPI+OgTg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F53DC113CC;
	Sat, 11 May 2024 01:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715391762;
	bh=B98QXwaMAkRfgO2gYmiRCq3L4jfQpvnIuCNjwrmLHLM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=BPI+OgTglWOHm/ORkzJT4reyKD78QnaHWRbN7umgcuTaM2SCoF4FNGPlyenp7GZcy
	 mv21GgnXmircxJy9G+WoEQICqELkVPOHhJNDB4g72U0vmZpSK8mcIZUYjBn2+MjgGF
	 TGja5L4vSNsphrFTlW/vY1YhzQ6peTFFOPEwshYEtxqTvtGW/8BlJgDj5aWJ1CYW+B
	 tqmX4/6E6ZC6PdS+Crf3n/wdoJn/Txj+DSA51/s/ZHfWdhaUYO2JUBxWyeuIWIznQW
	 qo2rmhSMoQQCJyeFusm7eGMyTVtaccmvQQFA29dykIne8r/4B4L/4CALBslW2buvXI
	 iWQDBCrG90+ig==
Message-ID: <d1361cc9104390c1d5971e4618934dbe942fae92.camel@kernel.org>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: Add RUN_MPTCP_TEST macro
From: Geliang Tang <geliang@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Matthieu Baerts
	 <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Mat Martineau
 <martineau@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,  Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,  LKML
 <linux-kernel@vger.kernel.org>, Network Development
 <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, "open list:KERNEL
 SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Geliang Tang
 <tanggeliang@kylinos.cn>
Date: Sat, 11 May 2024 09:42:30 +0800
In-Reply-To: <CAADnVQJM73g9gTq3GxR-RMmpJPK3DGgzUTQiJXjz_B1G_4JAAw@mail.gmail.com>
References: 
	<20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-0-e2bcbdf49857@kernel.org>
	 <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-2-e2bcbdf49857@kernel.org>
	 <CAADnVQJ5-APFxMeGsUDSWBsiAbhJGivs=fBUapgYEFNHgnEVeA@mail.gmail.com>
	 <d28dec16-9029-42f5-b979-a0f11656a991@kernel.org>
	 <CAADnVQJM73g9gTq3GxR-RMmpJPK3DGgzUTQiJXjz_B1G_4JAAw@mail.gmail.com>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-05-07 at 13:51 -0700, Alexei Starovoitov wrote:
> On Tue, May 7, 2024 at 9:02 AM Matthieu Baerts <matttbe@kernel.org>
> wrote:
> > 
> > Hi Alexei,
> > 
> > Thank you for the review!
> > 
> > On 07/05/2024 16:44, Alexei Starovoitov wrote:
> > > On Tue, May 7, 2024 at 3:53 AM Matthieu Baerts (NGI0)
> > > <matttbe@kernel.org> wrote:
> > > > 
> > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > > 
> > > > Each MPTCP subtest tests test__start_subtest(suffix), then
> > > > invokes
> > > > test_suffix(). It makes sense to add a new macro RUN_MPTCP_TEST
> > > > to
> > > > simpolify the code.
> > > > 
> > > > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > > > Reviewed-by: Mat Martineau <martineau@kernel.org>
> > > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > > ---
> > > >  tools/testing/selftests/bpf/prog_tests/mptcp.c | 12 ++++++++--
> > > > --
> > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > > > b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > > > index baf976a7a1dd..9d1b255bb654 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > > > @@ -347,10 +347,14 @@ static void test_mptcpify(void)
> > > >         close(cgroup_fd);
> > > >  }
> > > > 
> > > > +#define RUN_MPTCP_TEST(suffix)                                
> > > > \
> > > > +do {                                                          
> > > > \
> > > > +       if (test__start_subtest(#suffix))                      
> > > > \
> > > > +               test_##suffix();                               
> > > > \
> > > > +} while (0)
> > > 
> > > Please no.
> > > Don't hide it behind macros.
> > 
> > I understand, I'm personally not a big fan of hiding code being a
> > macro
> > too. This one saves only one line. Geliang added a few more tests
> > in our
> > tree [1], for a total of 9, so that's only saving 9 lines.
> > 
> > Related to that, if you don't mind, Geliang also added another
> > macro --
> > MPTCP_SCHED_TEST -- for tests that are currently only in our tree
> > [2]
> > (not ready yet). We asked him to reduce the size of this macro to
> > the
> > minimum. We accepted it because it removed quite a lot of similar
> > code
> > with very small differences [3]. Do you think we should revert this
> > modification too?
> 
> Yeah. Pls don't hide such things in macros.
> Refactor into helper function in normal C.

I do agree to remove this RUN_MPTCP_TEST macro. But MPTCP_SCHED_TEST
macro is different. I know this type of macro is unwelcome. But it's
indeed a perfect place to use macro in MPTCP bpf sched tests.

From

'''
static void test_first(void)
{
	struct mptcp_bpf_first *skel;

	skel = mptcp_bpf_first__open_and_load();
	if (!ASSERT_OK_PTR(skel, "open_and_load: first"))
		return;

	test_bpf_sched(skel->obj, "first", WITH_DATA, WITHOUT_DATA);
	mptcp_bpf_first__destroy(skel);
}

static void test_bkup(void)
{
	struct mptcp_bpf_bkup *skel;

	skel = mptcp_bpf_bkup__open_and_load();
	if (!ASSERT_OK_PTR(skel, "open_and_load: bkup"))
		return;

	test_bpf_sched(skel->obj, "bkup", WITH_DATA, WITHOUT_DATA);
	mptcp_bpf_bkup__destroy(skel);
}

static void test_rr(void)
{
	struct mptcp_bpf_rr *skel;

	skel = mptcp_bpf_rr__open_and_load();
	if (!ASSERT_OK_PTR(skel, "open_and_load: rr"))
		return;

	test_bpf_sched(skel->obj, "rr", WITH_DATA, WITH_DATA);
	mptcp_bpf_rr__destroy(skel);
}

static void test_red(void)
{
	struct mptcp_bpf_red *skel;

	skel = mptcp_bpf_red__open_and_load();
	if (!ASSERT_OK_PTR(skel, "open_and_load: red"))
		return;

	test_bpf_sched(skel->obj, "red", WITH_DATA, WITH_DATA);
	mptcp_bpf_red__destroy(skel);
}

static void test_burst(void)
{
	struct mptcp_bpf_burst *skel;

	skel = mptcp_bpf_burst__open_and_load();
	if (!ASSERT_OK_PTR(skel, "open_and_load: burst"))
		return;

	test_bpf_sched(skel->obj, "burst", WITH_DATA, WITH_DATA);
	mptcp_bpf_burst__destroy(skel);
}

static void test_stale(void)
{
	struct mptcp_bpf_stale *skel;

	skel = mptcp_bpf_stale__open_and_load();
	if (!ASSERT_OK_PTR(skel, "open_and_load: stale"))
		return;

	test_bpf_sched(skel->obj, "stale", WITH_DATA, WITHOUT_DATA);
	mptcp_bpf_stale__destroy(skel);
}
'''

to

'''
#define MPTCP_SCHED_TEST(sched, addr1, addr2)                   \
static void test_##sched(void)                                  \
{                                                               \
        struct mptcp_bpf_##sched *skel;                         \
                                                                \
        skel = mptcp_bpf_##sched##__open_and_load();            \
        if (!ASSERT_OK_PTR(skel, "open_and_load:" #sched))      \
                return;                                         \
                                                                \
        test_bpf_sched(skel->obj, #sched, addr1, addr2);        \
        mptcp_bpf_##sched##__destroy(skel);                     \
}

MPTCP_SCHED_TEST(first, WITH_DATA, WITHOUT_DATA);
MPTCP_SCHED_TEST(bkup, WITH_DATA, WITHOUT_DATA);
MPTCP_SCHED_TEST(rr, WITH_DATA, WITH_DATA);
MPTCP_SCHED_TEST(red, WITH_DATA, WITH_DATA);
MPTCP_SCHED_TEST(burst, WITH_DATA, WITH_DATA);
MPTCP_SCHED_TEST(stale, WITH_DATA, WITHOUT_DATA);
'''

We can save so many code, and perfectly use BPF test skeleton template.
It's small enough, and be difficult to refactor with a helper function
in normal C.

Please reconsider whether to delete it, or at least keep it until the
day it is officially sent to BPF mail list for review.

Thanks,
-Geliang

> 
> But, what do you mean "in your tree" ?
> That's your development tree and you plan to send all that
> properly as patches to bpf-next someday?
> 
> > 
> > [1]
> > https://github.com/multipath-tcp/mptcp_net-next/blob/4369d9cbd752e166961ac0db7f85886111606301/tools/testing/selftests/bpf/prog_tests/mptcp.c#L578-L595
> > 
> > [2]
> > https://github.com/multipath-tcp/mptcp_net-next/blob/4369d9cbd752e166961ac0db7f85886111606301/tools/testing/selftests/bpf/prog_tests/mptcp.c#L559-L576
> > 
> > [3]
> > https://lore.kernel.org/mptcp/cover.1713321357.git.tanggeliang@kylinos.cn/T/#m0b9c14f1cbae8653c6fd119f6b71d1797961d6ba
> > 
> > Cheers,
> > Matt
> > --
> > Sponsored by the NGI0 Core fund.
> > 

