Return-Path: <linux-kselftest+bounces-42765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAB2BB8FB3
	for <lists+linux-kselftest@lfdr.de>; Sat, 04 Oct 2025 18:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CFB21894BA5
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Oct 2025 16:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69A027CCE0;
	Sat,  4 Oct 2025 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEBuwWWA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDC8248F66
	for <linux-kselftest@vger.kernel.org>; Sat,  4 Oct 2025 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759594579; cv=none; b=V5EWYSXK3PO2P6SSr4KoOvXkmiFVCZMrAF7rQiRukznPaY97h6sUbP2siJdxyqYQ6gz6JAy+iZsO62YGjNderagqfLU6+fv257d7Z4tBBSEZCrwxCRr38TgKnHDYTnPCkgPFIK4V7s98V9EPW6iADtI1pafuAjHL5cNJ6FTuMTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759594579; c=relaxed/simple;
	bh=BFtFWz45fCHfJppYTWPt51ZzCzGvzVWdQH30FH6IQUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c123/oaZeW0evjExeuMCwMiJOf2LLGVttfPl0U1bCdvkMcm1P9Gc8rZjDNXKSAwd3ZPmv5VhN2eIfyfCME35496Q1+FsKVrF/mzD+gqYKtMTKPwXyPs3wYO8otmgIIKeFsRLPqxwuU2/O1Ry3Jf6HmAL71qbnL5Edez2RecxXM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEBuwWWA; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42557c5cedcso1786238f8f.0
        for <linux-kselftest@vger.kernel.org>; Sat, 04 Oct 2025 09:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759594576; x=1760199376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFtFWz45fCHfJppYTWPt51ZzCzGvzVWdQH30FH6IQUc=;
        b=MEBuwWWA9jG+HkRdcJFUB/0ltpuZgooele6Ye5mDK+4vq96J1dYnFPwL77ItXw5KyF
         6LhBiMF6o81Mb5hhyyDhYnILOzIBLgTZX2m1wQw3BIofmoya+kdnDViUNOCX2sQMswYH
         uWz8xBj6op4IWnPsAN2atKfCuL1V9wIgBom3uDtrZb0J6kH31fJmIOeUYCvYg3IMKffG
         Zx5B/lGX54JMm68jvoLD5xYdiJbNd6R/Jc0xit/8+g9mohzPHsW0OqK1U/A5glGdyEWP
         z/Tc39KnyDXiMne35jPL7ver7a2sfWgg//dDYvCpANgGoIsXQfqrSyh5+vInGzKFYrB9
         j/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759594576; x=1760199376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFtFWz45fCHfJppYTWPt51ZzCzGvzVWdQH30FH6IQUc=;
        b=QPQzoJRLCtd+sQNa0Rrjms7f6tw+vV6tgwFhwx/8Iv/pkYEv44ffT7imUPN+7Hx6UI
         bwszKszVuhpJ+MgQcBMR0BT2w1R0qcUdALfi4P70LGCwySL/g9LfJL2SgwfMJ8F5I2Iw
         7lFQeGG1QC/3nfezjBBJFCIPJYpfzDBwgEN+LoXh7h8G0YnFpb1ugsw2kq4L1c0I4sll
         5wNGo8atz9ERmqXWf+VYDEA2DRYia0IBVYjZS7FAxpMXa+vxkVmrrzfRLzeZFvE8MAWy
         ZPNO0oAUDM4Pf2tz8p8UUhCFRQqovdNMKEIxpQwUpw3bzI1eWA4Tuj/eGr8+CG8npvZx
         XV8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVa+7xxwz5u2cyoSv0ayghWM3mXYAHFmpNSCEf29NtB9KWISg5CJ1XCnxnjW3ddwXdRBh3RzM9klx4lmkE8kAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFOb5R3tMgUJI6tA33P1JHAIkpdJ7CayrHEQuH87eQtrz1cITA
	0HE/KPQuiTI3BDXTiUdpojr2p/a8nYaBaXfkc6V3kKGqzz0xZv+EcBuPwvGRONELk/IBpPlWzis
	Z6S7la4Ec1qOwlkIX9gVil8AKgAqmYDA=
X-Gm-Gg: ASbGncuw6JBLYR6qYy98A8C+kuKpXe4Dpl9ZKltQliYYSFCt/wkS1rBfcnD5EY1AQIw
	MsgARx7gM694aE/M7HNEh2CS478eO2nTM+0TKBgH/pUN55ceFGu2aAz8aAC8fPMncHt3y7sEJDU
	wiEPMON0l2uiscNLEptTl28kdxcIPBHtQAZj6zKG4EwEYXnW46M6Xu+yKvHv1fv+/sRR12/MQ3N
	Lpo4ceJ4fzw3OBEyAHcBj0FGiSi0TfRxe3zqfkfwuKMK0RCo1qZW21Cp8W99a5uK4UkHec=
X-Google-Smtp-Source: AGHT+IG/MV88gOTgIBtKglK8w1B5S7CgfnDOr0uIJuq9YH1xAWacU7h3e14hKjJmdWrb0tfBYx6T3oHJx47i8VNfTVc=
X-Received: by 2002:a05:6000:2401:b0:3ea:e0fd:28e8 with SMTP id
 ffacd0b85a97d-4256719e9c6mr4129999f8f.32.1759594575949; Sat, 04 Oct 2025
 09:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_1259E1972E2A9FAF3DA342882306E1421308@qq.com>
In-Reply-To: <tencent_1259E1972E2A9FAF3DA342882306E1421308@qq.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 4 Oct 2025 09:16:04 -0700
X-Gm-Features: AS18NWCQqriAfAUku8dSRijSYcwsuw4WSLelAlUXdhySmf6if1b2NeynApQdIj0
Message-ID: <CAADnVQJ5oEi0iiS+_N1f=K+0oTdDswGiESrd1tve_F_7aMOCBQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf_doc: Support 1st const parameter of bpf_d_path()
To: Rong Tao <rtoax@foxmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Rong Tao <rongtao@cestc.cn>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Paul Chaignon <paul.chaignon@gmail.com>, 
	Tao Chen <chen.dylane@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin Kelly <martin.kelly@crowdstrike.com>, Anton Protopopov <a.s.protopopov@gmail.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Al Viro <viro@zeniv.linux.org.uk>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 4, 2025 at 7:24=E2=80=AFAM Rong Tao <rtoax@foxmail.com> wrote:
>
> From: Rong Tao <rongtao@cestc.cn>
>
> Since commit 1b8abbb12128 ("bpf...d_path(): constify path argument"),
> the first parameter of the bpf_d_path() has been changed to a const
> constant. We need to modify the header file and bpf_doc.py.

...

> Fixes: 1b8abbb12128 ("bpf...d_path(): constify path argument")
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

Thanks. I reworded the commit message and applied it to the bpf tree.

