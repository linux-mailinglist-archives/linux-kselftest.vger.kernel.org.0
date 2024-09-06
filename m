Return-Path: <linux-kselftest+bounces-17398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 029A196F678
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 16:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1DD286B9A
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 14:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD1F1CF7AD;
	Fri,  6 Sep 2024 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gFqGsySk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R2Q+vklh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02DD19E7FF;
	Fri,  6 Sep 2024 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725632205; cv=none; b=Ayqr7+Mb0ic3wmpOHp1voD/TX5sB8E94gnaIbfXHfQjhl7RdyrAjj+qvKg16du7AGtL707X5+ha2PCJpXZzMXDK0FAsSnQ6FKIyrY8UqGwyk723HBjvYfXiNUOMenUSuLJxNx8BbqVqDXmvoXuiVldaJBvR/Khjt5vPHHLmCaak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725632205; c=relaxed/simple;
	bh=8nwCI7w7G19jZLwfkBD0ekkM2ohaR/RW6frdGyNyCms=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D/MWVQcnZNLmN6nJYQbKlHpjl9z0TlEFxqeeFaEdMJWcNsCCV8kGgeaSJns0Tk/h2J1VDUX4La+9AochkgD1CA5U4FOkLshk8lN7HzBCCwHJctup/DSbKq6elnH/r6LugoJlbaQoAl/Wg0DQ/v8oZJfw0yO+dECnYcVH/UEW/j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gFqGsySk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R2Q+vklh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Florian Kauer <florian.kauer@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725632202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UpbKsEr6u87l1eJRzDjfnxvEOGeeHA+R0XZxE7JwcWI=;
	b=gFqGsySk24RvRugaQDl8OMDeCH6BQAINf0yriBPlMd2A8NOBUkvBRtah4ypU0yBOOTcTSo
	Xl5zI/5obkJFhjg0ncNuu2fN7hGqrG2pljW0S8/p4q/sg8rfcnLeQE5F5aFqijCE8JVjx6
	GPvk28/81X85GoKJc+Aq+fsr94RZJ0Pyw/dYML9RciimGQJe2d4WM+Zi+GG9X897X7iibE
	iBfBlq43OU+FT56Hh6HBylEVyyTGTf99APf4wbqlQibGlKKupkkce7Zo0cYIMetYBHxKXP
	Kn2o1x3zBMF6cBy/seNp/dMPwIcHKpvgvVKwQY5bNJ3ltyvPR3kpF7SBKcDWew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725632202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UpbKsEr6u87l1eJRzDjfnxvEOGeeHA+R0XZxE7JwcWI=;
	b=R2Q+vklhyqttoyUdM5vzk6HwA011IxoU0xI553Cbd5ELYeTyKdJVObL1cfQ9zuQqDoSj2S
	iByyXviBIyQPuuCA==
Subject: [PATCH net v2 0/2] bpf: devmap: provide rxq after redirect
Date: Fri, 06 Sep 2024 16:16:24 +0200
Message-Id: <20240906-devel-koalo-fix-ingress-ifindex-v2-0-4caa12c644b4@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALgO22YC/42NQQ6CMBBFr0Jm7Zi2oqSuvIdhAcwAE0lrWmwwp
 He34QQu3/8//+0QOQhHuFc7BE4SxbsC5lTBMHduYhQqDEaZWll1ReLEC758t3gcZUNxU+AYUUZ
 xxBv21tgL1Y2m/gbl5R24zA7DExyv0JZwlrj68D2sSR/V34KkUSNp0ylq6sHY4bGI+6zBO9nOx
 NDmnH+l3gKj1wAAAA==
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 David Ahern <dsahern@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>, 
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>, 
 linux-kselftest@vger.kernel.org, 
 Florian Kauer <florian.kauer@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=980;
 i=florian.kauer@linutronix.de; h=from:subject:message-id;
 bh=8nwCI7w7G19jZLwfkBD0ekkM2ohaR/RW6frdGyNyCms=;
 b=owEBbQKS/ZANAwAKATKF5IolV+EkAcsmYgBm2w6+IurT5S5lIccHtsN7RdH3Dacfe5fDPFOmx
 uB6/FY7TkaJAjMEAAEKAB0WIQSG5cmCLvpm5t9g7UUyheSKJVfhJAUCZtsOvgAKCRAyheSKJVfh
 JACbEADJqtAhCavFErlA0jU/euOVnU5jh6H9vnzwaZteXqoKAtTgeLgSk31X7PRpoiFgqtQIjq/
 mIXh+KSp0EBULyJ9KgLGQqU93AVrghPYpoQ+7vKcwLTOyauO2OWbvYW81KhekNJGahQ8kMN+dJV
 WACRLUdj99BcxrsdHNkLgN5GYBxy6i1QvzfYQwXXVFEKGls3Y/orq5iF9VfXUz+7dGsuQv4MNGr
 0SuKa1Z2LfThhdzcSqEkfE0Boflpuj2wcSLKnBdP8uC7KjkWrraSkUX3toZWwOl6SCT6rzz7EXX
 6nuCnI0eju7hckka0yEpxAmIwMIlZwHq4L2Noxtrb03ZWWCf+vhhu115VMOrdBqpkJx8wWAfyCy
 JNhQaRYB/zqPrS8juI41p8SBAUu4SkW1AegsqfH7q36NwA1zugJIIIOuJRsGG+dnMImI0A+OW/D
 ancoRgB8sTBj9gOXjBF2NaTNzkmKZHR0Dy3OtTVYkBR96KDUOmsiVGZc+6yykndRwGWgtl5DpPY
 7Plb2abrAuYT4ldGxgtfCrHK8xdOfKekudGswH2P7AUt1JWf8XE1Kp0A5LEziZdhRCWdstiHp7q
 EfQy8SWd6UtnUJhQATx/a1dGZ27TvbNnhUoNPF/7siuAcyaTu8VcH0wFZfXfaiTdhbCfC4U/MIG
 Y6zcfz+phavarnw==
X-Developer-Key: i=florian.kauer@linutronix.de; a=openpgp;
 fpr=F17D8B54133C2229493E64A0B5976DD65251944E

rxq contains a pointer to the device from where
the redirect happened. Currently, the BPF program
that was executed after a redirect via BPF_MAP_TYPE_DEVMAP*
does not have it set.

Add bugfix and related selftest.

Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
---
Changes in v2:
- changed fixes tag
- added selftest
- Link to v1: https://lore.kernel.org/r/20240905-devel-koalo-fix-ingress-ifindex-v1-1-d12a0d74c29c@linutronix.de

---
Florian Kauer (2):
      bpf: devmap: provide rxq after redirect
      bpf: selftests: send packet to devmap redirect XDP

 kernel/bpf/devmap.c                                |  11 +-
 .../selftests/bpf/prog_tests/xdp_devmap_attach.c   | 114 +++++++++++++++++++--
 2 files changed, 115 insertions(+), 10 deletions(-)
---
base-commit: 8e69c96df771ab469cec278edb47009351de4da6
change-id: 20240905-devel-koalo-fix-ingress-ifindex-b9293d471db6

Best regards,
-- 
Florian Kauer <florian.kauer@linutronix.de>


