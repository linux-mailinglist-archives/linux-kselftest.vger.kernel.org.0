Return-Path: <linux-kselftest+bounces-37058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992FCB0119D
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 05:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6135064252A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 03:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D7219D884;
	Fri, 11 Jul 2025 03:22:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1139419C556;
	Fri, 11 Jul 2025 03:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752204167; cv=none; b=W2hxCC5ijSlrSJQ2TyQFdYQEZqRV05XxZ9W+2dbXCJ//VgzUbZU4DTXxccXfKMdy6FzjCImY+hrDV5VYWL87V5daGoXtQkvhvKjc/xrv2OgNfKIzICXpFlNIEi1xHEUtvfLStkia/FJFgBy/n62OsEfB153zZ0CzbcupzrifrIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752204167; c=relaxed/simple;
	bh=AOMERvCwHn+nDByLA1zBfaEarNOSftfY+xvP8R8XKvE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=fgAQMaJUzSlHVsxz4O80U8Mbmr4mcPxnAQ7afoU3JRFd6vd7n2fpeq8KHxf/DgJPOUmAg37ynDyo9qgP7+Qh2w4wUIoJgv7UYSHopsJ13mAGlUlofyqvXrm8u3Ei3LKIDbbCl6D0/eqT4ONzNUpkeCvaevoGlgthh47CLiMWUWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 7B89F110CE2;
	Fri, 11 Jul 2025 03:22:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 97CAB2000D;
	Fri, 11 Jul 2025 03:22:35 +0000 (UTC)
Date: Thu, 10 Jul 2025 23:22:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tengda Wu <wutengda@huaweicloud.com>
CC: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, Yuanhe Shu <xiangzao@linux.alibaba.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_-next=5D_selftests/ftrace=3A_Prevent_p?=
 =?US-ASCII?Q?otential_failure_in_subsystem-enable_test_case?=
User-Agent: K-9 Mail for Android
In-Reply-To: <2bf277fb-a1b8-47f8-9133-e3ca27327eda@huaweicloud.com>
References: <20250710130134.591066-1-wutengda@huaweicloud.com> <20250710153409.3135fb17@batman.local.home> <2bf277fb-a1b8-47f8-9133-e3ca27327eda@huaweicloud.com>
Message-ID: <17189AF8-34DC-4E5C-9233-ECADAECBBD26@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 97CAB2000D
X-Stat-Signature: rsybpaqecasmewttfb7hque4sw3nmd4c
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+jeMYjTDi2JaJ5j5GAHF08erVJMS/K1Kk=
X-HE-Tag: 1752204155-110836
X-HE-Meta: U2FsdGVkX1+ezatnzjfsETpKVj2ysZSUlftTfPcdsnJymo1vta4pcBVQla7FuSgHwhgzARc7k591EzkdEOdrd5v3DOqh8GuzjDWZAFPF5zQkZenXP073HwCpbJB+gIAWIJmcZ0f7mEkrWfIo6BmYnajgIRsbOirlQ2Bm21r0ZU2thMX8DgtW6l73Xg5MJhBpCR/dRLt5m4Yl4m4ZOQk6fVlvcAcgKXMDkWNiz0lTmE5Ez+lbSL0W+pxvOJDQxLlsg/wowvT7LQx7Gc0bfz8g1F5wtrYrblRFnbxasaH0ij0I23fVHPKJvZmyDMaZUHp5XzuRit+28et/xfnhFCyDh5XQm4N9l6yX+9y+2ea6K4ePw5rh4SyJSD/U5pcBBaPj7NI3YGp26pY=



On July 10, 2025 10:48:54 PM EDT, Tengda Wu <wutengda@huaweicloud=2Ecom> w=
rote:
>

>The patch works well - after ~50 test iterations, we haven't observed any
>recurrence of the test case failures=2E
>
>However, I'm concerned that using 'cat trace_pipe' (like the original
>'cat trace' method) could bring back the stopping problem [1] on slower
>systems=2E
>
>Could a slow trace_pipe reader (slower than sched event generation rate)
>reintroduce the original race condition?
>

Only if it doesn't find three different events, in which case the test wou=
ld fail regardless=2E

The awk script exits out as soon as it finds 3: unique events=2E It won't =
go forever, even on slower machines=2E

-- Steve

>[1] https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2E=
git/commit/?id=3D1a4ea83a6e67f1415a1f17c1af5e9c814c882bb5
>
>Some test details:
>
>$ =2E/ftracetest -vvv subsystem-enable=2Etc
>[=2E=2E=2E]
>+ echo sched:*
>+ yield
>+ ping 127=2E0=2E0=2E1 -c 1
>PING 127=2E0=2E0=2E1 (127=2E0=2E0=2E1) 56(84) bytes of data=2E
>64 bytes from 127=2E0=2E0=2E1: icmp_seq=3D1 ttl=3D64 time=3D0=2E538 ms
>
>--- 127=2E0=2E0=2E1 ping statistics ---
>1 packets transmitted, 1 received, 0% packet loss, time 1ms
>rtt min/avg/max/mdev =3D 0=2E538/0=2E538/0=2E538/0=2E000 ms
>+ check_unique
>+ cat trace_pipe
>+ grep -v ^#
>+ awk=20
>        BEGIN { cnt =3D 0; }
>        {
>            for (i =3D 0; i < cnt; i++) {
>                if (event[i] =3D=3D $5) {
>                    break;
>                }
>            }
>            if (i =3D=3D cnt) {
>                event[cnt++] =3D $5;
>                if (cnt > 2) {
>                    exit;
>                }
>            }
>        }
>        END {
>            printf "%d", cnt;
>        }
>+ count=3D3
>+ [ 3 -lt 3 ]
>+ do_reset
>[=2E=2E=2E]
>
>Regards,
>Tengda

