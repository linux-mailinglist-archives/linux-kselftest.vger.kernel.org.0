Return-Path: <linux-kselftest+bounces-18293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E826298441C
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 13:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D05280C48
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 11:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84281A4E98;
	Tue, 24 Sep 2024 11:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Awmrk2EQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3375A1F5FF;
	Tue, 24 Sep 2024 11:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727175812; cv=none; b=jvKLNNih7P5BiTLIXQ806ZFzCEuu9kYsVlf8Zc6lXLhCWMwv3IZj1w9UMzo0in60no4CcvZ7QHWjGG1xKGOxgahtsDSwst1e9+1LcgNl3laYUmd83eelALYLc5BhwLaH8Q8BE2k0bN7QjeB9v14FS52FvDvwgsFeKAGAdoIeZMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727175812; c=relaxed/simple;
	bh=xicL/frCZY1KbKzVSB1P6euV3wP208zF7BMKF9c/vVc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UYD2lz1oeB/jSo6VYFkH7fu1h/dL8x+/OtU3OQD5i6CtRcbUwf0tIW+8GcAKJf71TD5IbL5JHQeyfHolFOAQoc6R4N3Uq3vX5VhesZGbZ1KfFhM0MFijwUCslw6lmP5uHQUfRW/yWAGgQDlMWfLQjfJpMkLmpldPLqfREHb5vlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Awmrk2EQ; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1st2k0-001R8i-5d; Tue, 24 Sep 2024 12:25:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=o17RNvtJLEnk+WRoWMXcR0GFHekQdtyQbeL3ND3m24g=; b=Awmrk2EQxvwLvZG8l17tjV3qSP
	cD8g1keRjpF3qsNeuw4Xfpx+Zrya9DZorn+cUkpvnplg85s6lFlAQo+u7Wl10sgKY+Xara7nUWph5
	SEhXn/0dujJl+PXtV456W9ebI6x2XgUVscklxLFwEWSL4miOTAs+tOpyXf0HPxmBrhFw5h9e/nwRp
	m6dRHhHIyo1KYdxnJKg2iG+DDatmFY3BWOVVWbBogYJHbDd4K7tilcCUtI6gmV+DuhCoMjG5CeTvP
	4jkJAtFI+wNW9LTC0DZhWTw+WGgrHziTipBs0pqPoY6PcCpR9cyL49S6nKYAFEcl4/boYWOsv01lY
	coohFDlQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1st2jz-00069y-FB; Tue, 24 Sep 2024 12:25:55 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1st2je-00H6oF-ST; Tue, 24 Sep 2024 12:25:34 +0200
Message-ID: <e78254c5-8f2f-4dc5-bf81-401caefabdd1@rbox.co>
Date: Tue, 24 Sep 2024 12:25:33 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf-next v2 0/6] selftests/bpf: Various sockmap-related
 fixes
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
 <87y159yi5m.fsf@cloudflare.com>
 <249a7dc3-34e2-4579-aae7-8b38b145e4bb@rbox.co>
 <87ttfxy28s.fsf@cloudflare.com>
 <42939687-20f9-4a45-b7c2-342a0e11a014@rbox.co>
 <877cccqnvj.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <877cccqnvj.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/24 22:05, Jakub Sitnicki wrote:
> On Wed, Aug 14, 2024 at 06:14 PM +02, Michal Luczaj wrote:
>> On 8/6/24 19:45, Jakub Sitnicki wrote:
>>> On Tue, Aug 06, 2024 at 07:18 PM +02, Michal Luczaj wrote:
>>>> Great, thanks for the review. With this completed, I guess we can unwind
>>>> the (mail) stack to [1]. Is that ingress-to-local et al. something you
>>>> wanted to take care of yourself or can I give it a try?
>>>> [1] https://lore.kernel.org/netdev/87msmqn9ws.fsf@cloudflare.com/
>>>
>>> I haven't stated any work on. You're welcome to tackle that.
>>>
>>> All I have is a toy test that I've used to generate the redirect matrix.
>>> Perhaps it can serve as inspiration:
>>>
>>> https://github.com/jsitnicki/sockmap-redir-matrix
>>
>> All right, please let me know if this is more or less what you meant and
>> I'll post the whole series for a review (+patch to purge sockmap_listen of
>> redir tests, fix misnomers). [...]
> 
> Gave it a look as promised. It makes sense to me as well to put these
> tests in a new module. There will be some overlap with sockmap_listen,
> which has diverged from its inital scope, but we can dedup that later.
> 
> One thought that I had is that it could make sense to test the not
> supported redirect combos (and expect an error). Sometimes folks make
> changes and enable some parts of the API by accient.

All right, so I did what sockmap_listen does: check
test_sockmap_listen.c:verdict_map[SK_PASS] to see if the redirect took
place for a given combo. And that works well... except for skb/msg to
ingress af_vsock. Even though this is unsupported and no redirect
actually happens, verdict appears to be SK_PASS. Is this correct?

Maybe I'm missing something, so below is a crude testcase I've cobbled
together.

And sorry for the delay, I was away from keyboard.
Michal

All error logs:
./test_progs:unix_vsock_redir_fail:1600: want pass=0 / drop=1, have 1 / 0
unix_vsock_redir_fail:FAIL:1600

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 4ee1148d22be..e59e1654f110 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1561,6 +1561,45 @@ static void vsock_unix_redir_connectible(int sock_mapfd, int verd_mapfd,
 	close(u1);
 }
 
+static void unix_vsock_redir_fail(int sock_mapfd, int verd_mapfd)
+{
+	int v0, v1, u[2], pass, drop;
+	char a = 'a';
+
+	bpf_map_delete_elem(sock_mapfd, &(int){0});
+	bpf_map_delete_elem(sock_mapfd, &(int){1});
+	zero_verdict_count(verd_mapfd);
+
+	if (socketpair(AF_UNIX, SOCK_STREAM, 0, u)) {
+		FAIL_ERRNO("socketpair(af_unix)");
+		return;
+	}
+
+	if (create_pair(AF_VSOCK, SOCK_STREAM, &v0, &v1))
+		return;
+
+	if (add_to_sockmap(sock_mapfd, v0, u[0]))
+		return;
+
+	if (write(u[1], &a, sizeof(a)) != 1) {
+		FAIL_ERRNO("write()");
+		return;
+	}
+
+	errno = 0;
+	if (recv_timeout(v0, &a, sizeof(a), 0, 1) >= 0 ||
+	    recv_timeout(v1, &a, sizeof(a), 0, 1) >= 0 ||
+	    recv_timeout(u[0], &a, sizeof(a), 0, 1) >= 0 ||
+	    recv_timeout(u[1], &a, sizeof(a), 0, 1) >= 0)
+		FAIL("recv() returned >=0, errno=%d", errno);
+
+	if (xbpf_map_lookup_elem(verd_mapfd, &(int){SK_PASS}, &pass) ||
+	    xbpf_map_lookup_elem(verd_mapfd, &(int){SK_DROP}, &drop))
+		return;
+	if (pass != 0 || drop != 1)
+		FAIL("want pass=0 / drop=1, have %d / %d", pass, drop);
+}
+
 static void vsock_unix_skb_redir_connectible(struct test_sockmap_listen *skel,
 					     struct bpf_map *inner_map,
 					     int sotype)
@@ -1582,6 +1621,23 @@ static void vsock_unix_skb_redir_connectible(struct test_sockmap_listen *skel,
 	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
 }
 
+static void unix_vsock_redir(struct test_sockmap_listen *skel, struct bpf_map *inner_map)
+{
+	int verdict = bpf_program__fd(skel->progs.prog_skb_verdict);
+	int verdict_map = bpf_map__fd(skel->maps.verdict_map);
+	int sock_map = bpf_map__fd(inner_map);
+	int err;
+
+	err = xbpf_prog_attach(verdict, sock_map, BPF_SK_SKB_VERDICT, 0);
+	if (err)
+		return;
+
+	skel->bss->test_ingress = true;
+	unix_vsock_redir_fail(sock_map, verdict_map);
+
+	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
+}
+
 static void test_vsock_redir(struct test_sockmap_listen *skel, struct bpf_map *map)
 {
 	const char *family_name, *map_name;
@@ -1883,6 +1939,7 @@ void serial_test_sockmap_listen(void)
 	test_unix_redir(skel, skel->maps.sock_map, SOCK_DGRAM);
 	test_unix_redir(skel, skel->maps.sock_map, SOCK_STREAM);
 	test_vsock_redir(skel, skel->maps.sock_map);
+	unix_vsock_redir(skel, skel->maps.sock_map);
 
 	skel->bss->test_sockmap = false;
 	run_tests(skel, skel->maps.sock_hash, AF_INET);

