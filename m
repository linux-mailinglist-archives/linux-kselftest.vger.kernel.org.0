Return-Path: <linux-kselftest+bounces-48027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F707CEC661
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 18:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B52C3001610
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 17:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702E92BF3F4;
	Wed, 31 Dec 2025 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="PeLjBzk6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f97.google.com (mail-ej1-f97.google.com [209.85.218.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216182BE048
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Dec 2025 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767202650; cv=none; b=I+VTixZFRP8vtXBO1s/kKLiFvg5qs5VDTrwyu78/+3i2eAmF2vgDk1ZJQRwOWBtB7rawrc8VKAdVYwbzX6a2veIzuN/qbWZB7DJFvPc4W/Z/KCvUb5qLzcD1llV1X359cjj5bi3wGGBwaacbtTMfTxY/2YG0f7ugx9lbp6SOcB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767202650; c=relaxed/simple;
	bh=WVYQGhpSvliDxHIS3oLwubflGM55eX6MoNuxuho0+Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfdtWEFqplBXEf+UxPb5ROgmFVIXxf4ogeJAyFEoVZPuzTeCDRN7NpAJnmG0G7cIXxmTNItSMlH5ZPBY/SfWZV7KRfAoutGcIJbGLWOuFNCCx4cW3dsTMFOKD1MqWeyokQ6rWqPiZ5V5qgXT5GsLT0/DSZMwUnnSA68kz/Liiuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=PeLjBzk6; arc=none smtp.client-ip=209.85.218.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f97.google.com with SMTP id a640c23a62f3a-b73612e620cso77125966b.1
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Dec 2025 09:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767202643; x=1767807443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPtJoM4BdsW1AWCT74nIdjccEavCkJ/nIFp8Za4jgwE=;
        b=PeLjBzk6HD/l348HM8MLW1j5beEB21RZ112O4uvyZIZLMA55gblkaKZ2+Mb91hFnY5
         3xyXEyfKbkFaEORoDTeGujBGvo9Mgde/bR0k4fKNzUS85UwkKgp3W5G4IWKl/0Yt8686
         aGl8ymFQekBTdTHyUb7uPi+WekMbyjU8IfBgsPor4YDI1E+PS5EKR5VYt4xEARUdsEG6
         Cb2SRjHTdMhPk5pvMjOOO25PIByS+KZaJmPUfT8OTpglbwB7dzhmMz9mcJNd0PEjCHyK
         ETY4LqgN3btjlMPs9EUGii6evKaTJ36XHobXs1b3Ubn4MCXySU0QB2d2dDRgXN3fWOaH
         r36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767202643; x=1767807443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CPtJoM4BdsW1AWCT74nIdjccEavCkJ/nIFp8Za4jgwE=;
        b=VEZXWl1V/qLdCUADu9FGOfWZE5BgSIcS2G3ec15I7zrZ2RIXCvFgSDeLff/yegDyDi
         SsL3OvzFYOV0d4IP/FQNDhJbkb0xBv/Oh9y4/tQyP0Ue2YsAmHQrokDQy2K1ngKcFOKW
         Ur/mw9c6aPp7zw8l6W73xbe+gp3hjj7XklNnQ/GT3Mp5zQ331CPKokNrpt2T9s74kj6P
         TNFpWF2G6kcXLRJqhdHkk+sn6ECl8jXKUHqZYGMa+2x0C6RCLTNI7Ix/FObVSCFtAkaN
         H8DlNXUM3gyrxR02EGRFqpkx0kMjD8UbOiftIR83+49sUHtwgtfGOJ/lUepgNvHo13O5
         uwXg==
X-Forwarded-Encrypted: i=1; AJvYcCWiaAG8ekkbetorJJ0C4NVXvDLsKMGkK+/dC6E4Rl6le064jWggsMM4DE1aNldiJG4aUkpQLhYS7lP7spyDCao=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfmLng+WC8SkT0sETCdazRdvzApYWFx8yIBwn2jgDd8AsOCje8
	Dr1FuOU+seDGta/IKlPqKgR7lMNvcwohNEfl96ybdBk0mkY6YIYrt8AZFpvtN163ezy95Zyccul
	lG+VpW5+iQrMbhXkWXQgjw73W75rCdsmtMZJh
X-Gm-Gg: AY/fxX5QRQUlDGfMQAEURvS7GbSrHKYD5hT14jfNOu+qwPfWI0D/Lu1vggPvORrnM3r
	h+Jpa82f/AL7SF+LB/1YYiLGssO3k4uzM9hFnnMYfqOdTHaL0g0oJjkLSEkiTi8ueg+MNee0WCV
	BjlkY/SKBPIRY2OmiAZSzo+HRG6I/ixJvRV8VpyjuV1IYs2RBea419bxRfNPEXY31mDtAjHiPPv
	xYVOLU3DGhLrjCyZHQi0u7eYPetOnNyI2SE23n7vgpPC4hxw6bj2Uyxf0QYAwYVvhvNWEDy+lSf
	y3oauo6o4K0PjAzsTdgxwoYtlBwa7bzptBDLQD7937s/5L3535JHgsVXceCyu4S4qCnLPyPKmTF
	AoAXHmcqzPH11C3KJbyuc8LQGhvjksr9IW6gTzapwqg==
X-Google-Smtp-Source: AGHT+IEi03ZQZjXAnQiEZTFYKeIsY3RuVDBYnomwpJqWJlLI46xo1bUhyzXBcQMLZiL4Tr8s0Id0tWh610wS
X-Received: by 2002:a17:907:7209:b0:b76:3548:c34c with SMTP id a640c23a62f3a-b80372602eamr1981571766b.8.1767202643158;
        Wed, 31 Dec 2025 09:37:23 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-b8037d637fasm499254166b.58.2025.12.31.09.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 09:37:23 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id CA50C34076F;
	Wed, 31 Dec 2025 10:37:21 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C307BE4234A; Wed, 31 Dec 2025 10:37:21 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/5] HID: bpf: make __bpf_hid_bpf_ops const
Date: Wed, 31 Dec 2025 10:36:30 -0700
Message-ID: <20251231173633.3981832-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251231173633.3981832-1-csander@purestorage.com>
References: <20251231173633.3981832-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that struct bpf_struct_ops's cfi_stubs field is a const pointer,
declare the __bpf_hid_bpf_ops global variable it points to as const.
This allows the global variable to be placed in readonly memory.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/hid/bpf/hid_bpf_struct_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index 702c22fae136..30ddcf78e0ea 100644
--- a/drivers/hid/bpf/hid_bpf_struct_ops.c
+++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
@@ -286,11 +286,11 @@ static int __hid_bpf_hw_request(struct hid_bpf_ctx *ctx, unsigned char reportnum
 static int __hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx, u64 source)
 {
 	return 0;
 }
 
-static struct hid_bpf_ops __bpf_hid_bpf_ops = {
+static const struct hid_bpf_ops __bpf_hid_bpf_ops = {
 	.hid_device_event = __hid_bpf_device_event,
 	.hid_rdesc_fixup = __hid_bpf_rdesc_fixup,
 	.hid_hw_request = __hid_bpf_hw_request,
 	.hid_hw_output_report = __hid_bpf_hw_output_report,
 };
-- 
2.45.2


