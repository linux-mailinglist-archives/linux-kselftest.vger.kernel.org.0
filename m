Return-Path: <linux-kselftest+bounces-40049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5EFB380AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 13:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75B9169D83
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 11:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1774341ABD;
	Wed, 27 Aug 2025 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsDr45aS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E709B1B425C;
	Wed, 27 Aug 2025 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756293420; cv=none; b=ABBhC/oU6cnPobyr9zPZGdbkP2kGXkUGDCxaMZsUCK6VDVl9G/ykcQCQHykAY5FvWPYpJBJh4WfLY9yMFUEr3NYKe0PIZkyoYZvKzovb/Xc1aZ9UgBqrJFnnF1alWhrxslDGXZu8E956Ib6ofTkAKqlEAEPJlyk20sDkYlQa5Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756293420; c=relaxed/simple;
	bh=laF4aCzdnYqqOiKe6TJk6V7rDYa2OP/TEOF4ueQbzRo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C6jffPMH0iVEe0Aeulpp27PUb206ksTCSu58GHHwvzyym/wqTrsJ29ykFKEzcDJ5xpOVdr+wLTscegKMo9YnquKGm7Y3R/Vwl8cuXeZk8LWJo3Bxq4hXN4kn/ftSrvGs5TZtrISrWsJS28VvTLsSB1BcQ2H6JpsmKINwDwI8B0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsDr45aS; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so4234270f8f.3;
        Wed, 27 Aug 2025 04:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756293417; x=1756898217; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NpRjwZvPLOD/qXd7yzG90qI1YNyMsZmvSBlze1Z94c4=;
        b=RsDr45aSoDhlg/eK393W0XTPieZmu8alGPsmg/jPxx3I65EO1Kq/bDAHRMuKxQwPO0
         aXQ7e2zX4JHxiR6z3WXkuMghoPU3mIqi7ybmU+26IxKob+ADpsweMQVDXhoZ1Jm6rn+e
         tjOL/1/F+Nnfoc0k2f93qXy9NIH3D49ZRcvu3rV8ohHVS2Vbj/QEU88d4qM1ThIAmq9T
         7VHTH+iMQ+vVals3O8YFfeT94XyNamrbURTI6pEolvQpR9r85lIwMbiasHw0vjKUXP2c
         XzuTFTTEziIHDG/YSnB95Jqn9dvqA/oU8oxx8wm/sPIslDkvYYS3o4l9PYZvf/suf+cQ
         huPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756293417; x=1756898217;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NpRjwZvPLOD/qXd7yzG90qI1YNyMsZmvSBlze1Z94c4=;
        b=c9ZvWsUxefOJumWYDBOuLdVZV7CSV9HBh3EQ+xsKsjbqFOWmmReAvfNPe6CwDYuYhE
         XQrG4oiDZGwmoFJt5RGDywgoX0/FpacxzF/IBWois6MulKBDEHCdKZEs4nLQUGbQix+H
         AAsXlvfb8GouKP3AJgbq1FwzwjcMwOxnisF7CjVqVoawa/BPnti+GYLfOqDMsL3V48s5
         /vF5tC/CinCEDFJPNIJF0iU7r5jOtkxUtJ1/Fv7rl24SS2vQHyNfg6tA4nXLfp1JYMFj
         nSHYn1GTJ3HaxgFPTRzRhJ6uGu6mUdYUSz5b4hZD6ttddHYdBdqmQF8+cxraUCRNqLXB
         BLoA==
X-Forwarded-Encrypted: i=1; AJvYcCXK4fxbhCj0ZJIXf2cacn7UwtR+O05UAo2Kz488g3d0sLmbiFERj/o6DH578/bl6UxamHes6BIDycx2fkgW@vger.kernel.org, AJvYcCXoAYSlGrNdK7DXdQOtRz6AEP420sPkskEcHssrVGNHXXfR8S6GKTiPMyWizpHA9c0//WQ=@vger.kernel.org, AJvYcCXpt2v/ifQFB5mPg1W3LIjcCuENV1TqvtlbS1K3WcR5ps/kOLvzsR2QXE7C67dYtECub368bpuATlrZI3QA80HH@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4qqfVPnKG13sFvkI2acywxqUBPk3pKWWr8iYPW5ugB44sSOBL
	mK5FtEi+KDIAHomrjYUZQvFh6a4aFulwWEJuTMDHA0Tec9HSi0lbQGbgCiqjn28vZJRQqQ==
X-Gm-Gg: ASbGncunXFluSdgr6a5cBhCnWXbAztGOgZEfKFab6S0gd4ARuKxO57IlBpIG7CYqga/
	biWycy981kgVBfpW9h13d5LUTxGyk4HU/R5vBP0R1n+ZwMSMNnfPC/B1vaR9hYLABtftQ8auroS
	KQWim1pKjarPkRkpdpc20J2ELSNbkAKxT0Cpjcmt5uAZz4Fh9FdliRRM6XSrgZ92fAZGbiCgMDL
	hxzFKRgSmqjWOjDP5ICXd7iG5K5rlVfl/7n752iVP2UC1zXUNtw5eYC/Wj2ljauTZMOLek203iV
	CztbpWlHnGFuADUUeLQ6uKK0aUof1VuYEQuL7XXmNnymadKdN/iIKrBRTtF5FO99wTz2r3SFKiN
	Mca61DPDuTZ2zK2fceCbTWwk/Tu0jXaUAng2OfWfp4jRSHeufozE2kA==
X-Google-Smtp-Source: AGHT+IHUDZ1Tch/bZVEatphfXZPYhJnc2lujMS/5Dy3W/Jlz6v8h2Z4+vQMwElC/Pu2wQHXGQZA7kg==
X-Received: by 2002:a05:6000:188c:b0:3ca:c607:adb9 with SMTP id ffacd0b85a97d-3cac607b09emr6033359f8f.5.1756293416955;
        Wed, 27 Aug 2025 04:16:56 -0700 (PDT)
Received: from localhost (54-240-197-230.amazon.com. [54.240.197.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4ba078sm22085879f8f.4.2025.08.27.04.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 04:16:56 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: KaFai Wan <kafai.wan@linux.dev>, xukuohai@huaweicloud.com,
 ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 mrpre@163.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add socket filter attach test
In-Reply-To: <139bf7d77750fdf04d26e1a77c0955466c9a4827.camel@gmail.com>
References: <20250813152958.3107403-1-kafai.wan@linux.dev>
 <20250813152958.3107403-3-kafai.wan@linux.dev>
 <eb6f9ba4acccc7685596a8f1b282667a43d51ca8.camel@gmail.com>
 <CANk7y0hQWOL3OW8Ok4e-kp7Brn5Zq6H5+EfS=mVtoVd+AUxZmA@mail.gmail.com>
 <35c18502a4870d8a833c1c9af20b85ca3f8a0ff6.camel@gmail.com>
 <CANk7y0gVNwX70ur0KkZKNkSDq7RH1xs5=dOHx_UCOErbwc7zhA@mail.gmail.com>
 <139bf7d77750fdf04d26e1a77c0955466c9a4827.camel@gmail.com>
Date: Wed, 27 Aug 2025 11:16:53 +0000
Message-ID: <mb61pv7m92evu.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eduard Zingerman <eddyz87@gmail.com> writes:

> On Mon, 2025-08-25 at 21:27 +0200, Puranjay Mohan wrote:
>
> [...]
>
>> Hi Eduard,
>> 
>> You were right, I have verified that the program is hitting the 0xfff
>> boundary while doing the call to bpf_skb_load_helper_32
>> While jiting this call, emit_a32_mov_i(tmp[1], func, ctx); is called,
>> where this issue it triggered.
>> 
>> The offset in imm_offset() is calculated as:
>> ctx->offsets[ctx->prog->len - 1] * 4 + ctx->prologue_bytes +
>> ctx->epilogue_bytes + imm_i * 4
>> 
>> For this program, ctx->offsets[ctx->prog->len - 1] * 4 itself is
>> 0x1400 which is above 0xfff boundary.
>> So, this is not a bug and expected behaviour with the current
>> implementation of the JIT.
>> 
>> For now, we can merge this and later I will try to improve the JIT so
>> it works for bigger programs.
>
> Hi Puranjay,
>
> Thank you for checking this!
> What do you think about this test case, do we need it in the suite?

I don't think that we need this test as it is based on a missing feature
in the JIT. Once the arm JIT is improved, this test will silently stop
testing what it is supposed to test (fallback to interpreter).

Thanks,
Puranjay


