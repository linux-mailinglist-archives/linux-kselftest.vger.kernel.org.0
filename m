Return-Path: <linux-kselftest+bounces-6138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15EC8771A0
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Mar 2024 15:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCA71B20CD5
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Mar 2024 14:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87E840869;
	Sat,  9 Mar 2024 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="v/CGk8qZ";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="ItXgBku6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FAA1E498;
	Sat,  9 Mar 2024 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.235.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709994587; cv=none; b=JvcZO8PVt7WF7WKP8K86EQ88rEuHpNVuv0gTYCK2HtMuFwL7ahUXczTiKMRHA88fd6jf2Rhoc9ZHRJmojF5S4s1zbBcANLy73khY9tV52A9PqeFybr2qcwW4AN0TIiTBBOUO7BSLn2hfktMp3lhn0+eLsfRSfEVn31MhveZh3zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709994587; c=relaxed/simple;
	bh=wTj/Z/kBhcFhDz57sChY8g+8iv5HKc19ElDHM2opLEo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uN601bnkhLVh+8nEjkBHOqxgCsuA0f50lrxdfX/G57F/6lX+ANjUv7+D0WCxlxw/c74Wr1ORw65BgtGKSOxAXnlY1uZKX9Dt1m8JFOaLDYiK1rBFASZM42iSHVMVwITACoSFJk24x52L91v9NPkRUCCBDSQ0jv5GR/ethuOtCsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr; spf=pass smtp.mailfrom=alu.unizg.hr; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=v/CGk8qZ; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=ItXgBku6; arc=none smtp.client-ip=161.53.235.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 66472601A1;
	Sat,  9 Mar 2024 15:29:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1709994582; bh=wTj/Z/kBhcFhDz57sChY8g+8iv5HKc19ElDHM2opLEo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=v/CGk8qZOF7jy8cvN7DK8qR0QUFeRjmj6UJRVyyIzyyRhhS12xbD/ShamJlmfrXmA
	 i8t4DRVVbxTw6zt+p1s6grJ4aCizm/yDk52oBsDI+sD782ajMgXaGfaBrJQiEeiD9E
	 WDUW09wYKetyoBR77nLxOb5nBq/XxZcUS3t58IFEF0vzV9uH7d4oekQizXn/VfbL21
	 lkYl0ouIuERoH8j1XTd1NTReiCEG5zIX+Egf5slcGoiX+5AY6T3UDzbu2BsxTgnCA0
	 c+sE9Kaz/srJ8RIU2wkRMAvehaCANH79pzyu8vT2CrWR8OZ0aodnaWBppPGb+eO9Cw
	 84m4qFq9OGE5g==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GhwdfwEdLrrI; Sat,  9 Mar 2024 15:29:40 +0100 (CET)
Received: from [192.168.178.20] (dh207-40-27.xnet.hr [88.207.40.27])
	by domac.alu.hr (Postfix) with ESMTPSA id 422E960189;
	Sat,  9 Mar 2024 15:29:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1709994580; bh=wTj/Z/kBhcFhDz57sChY8g+8iv5HKc19ElDHM2opLEo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=ItXgBku63zr7NJpWQIPH3qsO4neoLIzw/bn5z3H1KX38+u97fwQm3J0WwUDU8mg+y
	 1lrAyO23Z2pC5ZGSinrRyaC8EljTdysYEcV7ofmWZmNlUNH3Vqczql0wNpdNrP4qKd
	 bTwg4RLyp1/o65tO7NMBoMxVVXrgPP3LKbmFjHwfFzBlnYDAhSFqqeV04EZWQGXkA6
	 EGH5YlkF+YjogAnCp3Jx51VBbACJa5S7RBu/uTzxcx8tQZD9/Kr7p4zfrPiUaepNXt
	 dLJibQBdCdQAKC+ktAoZDlricdE3vgtDte8mtFVCMQSTVL24DR9HUdcs66h/31oD3x
	 358SvLl0IqQdA==
Message-ID: <c6aab6b2-79a7-456c-b640-1ba175b05a87@alu.unizg.hr>
Date: Sat, 9 Mar 2024 15:29:39 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG net-next selftests/pidfd] Hang in ./pidfd_setns_test
 pidfd_send_signal()
Content-Language: en-US
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To: Christian Brauner <brauner@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <e2ba3f8c-80e6-477d-9cea-1c9af820e0ed@alu.unizg.hr>
In-Reply-To: <e2ba3f8c-80e6-477d-9cea-1c9af820e0ed@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

P.S.

Please consider this additional dmesg diagnostics possibly coinciding with the kill -KILL <stale pids>:

[Sat Mar  9 15:18:05 2024] proc-empty-vm[1007004] vsyscall read attempt denied -- look up the vsyscall kernel parameter if you need a workaround ip:5a0754238702 cs:33 sp:7ffed57b6ec0 ax:0 si:0 di:0
[Sat Mar  9 15:18:06 2024] proc-pid-vm[1007025] vsyscall read attempt denied -- look up the vsyscall kernel parameter if you need a workaround ip:5cf038710e22 cs:33 sp:7ffc3cc4ee60 ax:0 si:0 di:0
[Sat Mar  9 15:18:08 2024] ICMPv6: process `read' is using deprecated sysctl (syscall) net.ipv6.neigh.default.base_reachable_time - use net.ipv6.neigh.default.base_reachable_time_ms instead
[Sat Mar  9 15:18:09 2024] sysrq: HELP : loglevel(0-9) reboot(b) crash(c) terminate-all-tasks(e) memory-full-oom-kill(f) kill-all-tasks(i) thaw-filesystems(j) sak(k) show-backtrace-all-active-cpus(l) show-memory-usage(m) nice-all-RT-tasks(n) poweroff(o) show-registers(p) show-all-timers(q) unraw(r) sync(s) show-task-states(t) unmount(u) force-fb(v) show-blocked-tasks(w) dump-ftrace-buffer(z)
[Sat Mar  9 15:18:55 2024] signal: openat2_test[1025119] overflowed sigaltstack
[Sat Mar  9 15:18:55 2024] signal: resolve_test[1025139] overflowed sigaltstack

Best regards,
Mirsad Todorovac

