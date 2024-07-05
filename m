Return-Path: <linux-kselftest+bounces-13255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6084F928E5D
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 22:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 144D81F25807
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 20:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6E51448C5;
	Fri,  5 Jul 2024 20:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEcFcFI6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E255208A7;
	Fri,  5 Jul 2024 20:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720212875; cv=none; b=mtVilQUnQFT31gXenEuTep2dR6AfvIqbIK4GdEYX6ABsmEpk8cmCSE0JIot8frSbbWbzUgta9byHMM6iGi2Gai7/0mQBiVNdbV7Nnf98j+j7P4C0wZYUAQWN1I0GoCxccOiNCdJDGwzU4F+XGnOkXCB8GQxLoQeer/v7UFNcx0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720212875; c=relaxed/simple;
	bh=2I6tlGLYky5rxRRydJ1VhSeXacy67dc3oRDvst05vCA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oD/FS6541AuSPtthLw/YEbvQxMHLXll323nexx4JIkxHT8qes4lbYQTV1daBr2PZr7Nap7GLm3thO5aQa9T2makYrZvkB+tmXilFGRKtNKHWC1ejxL9EcjUMvKbmj/KCqBQBxVpw+FL1REbpSeOBzkKetiCIuJbQC9HJEnyw4fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEcFcFI6; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-701b0b0be38so1569866b3a.0;
        Fri, 05 Jul 2024 13:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720212874; x=1720817674; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hd8PCDgMueMORbsxMdk25xl5YXQAP04XADlFMfIBmTg=;
        b=CEcFcFI6iAWwc2wRvbKWo1CJ4fLoaMX8DeSolpeFTykliNA/3Iu6j2v+K+nZSc/jPJ
         aE3p3rVf+C72ypccPnB7qSCymm3Ruk3RhFInogXIVQvsOj1jLBHf7n3qUMWgfT2maHvM
         yKPGHrpfQvO+RI2+W9AHEdgyGMEqQWD7/FFyPFJUmy+wNngbzk0Bg0JJxIgwXWTdaUKD
         7NWDBui4Y7aO4ZNDbpzUOdoXtKnJy1NPMVkTfZHjpRMlOLl8VWazegeKHKZ455HaTRau
         VfDIb49MrTx8JhUithphwfXrIHyNeX9dGHkJyHKYDaGnItUR72Ps9bBzkhGZQ+aeMmJl
         alKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720212874; x=1720817674;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hd8PCDgMueMORbsxMdk25xl5YXQAP04XADlFMfIBmTg=;
        b=MaAvJUnVfiAfQteoTpqg/yz7c50nsZRj90CD1W4N1kB6vuKo3duCDg2JDMYNj/az65
         14SQMjl1La9kmIqsWG51/nYFYipSJ8Q2F1LHEjAn4Ur0RN6ERIHoDSXkBbRsrF/CAp5A
         yyu4ZCRMYcnZdobmkFSGXfXMjm18GfRKsEYaUBgggLxI6QZWKPt2iF7IQEsHjYPwGEpA
         hFtbTG/WaxojX+1Wc4ZJF1n3pRkHA1L6yMtA7xR/vOR/ojdG3ulTB5Kej4vVKvQijUGu
         UxutcTkvVciC6JPwv1e2csp6cKBqCGyNpt6h6JgE0cPdsTcmb9qiY6Fbu7xs/+H9roP4
         y2tw==
X-Forwarded-Encrypted: i=1; AJvYcCW1EF/t1iVB35x7pBMTqFVIn0Zfr0F/rHs4cLRhIRggWhLnRnV9hZzizSmoYiXy1xD6N9cQfDwJrU+nWsJDta3IbTvohBe+dj3knoxQOhZpfXGOSWugva2aeLWo9EA9FbSY9UHSpe5Eh9LSGI0J
X-Gm-Message-State: AOJu0YycRrdWh37V621+1a36ShrKLImKZ/wV+wxDCqa0ALHNuhnJm5WT
	qMOMnvQ+TfqkMun0j8KvR2W64y/dpaJ9PsK7JibN9KG42/iVsqFc
X-Google-Smtp-Source: AGHT+IEPXB6ygUd16BDckadJNd0JfyBudXpraNukf45fIl/vUH5puKR2pY77kOTf66iIQ+8369EMpg==
X-Received: by 2002:a05:6a00:882:b0:70a:f3de:3ff with SMTP id d2e1a72fcca58-70b00951416mr6010816b3a.14.1720212873706;
        Fri, 05 Jul 2024 13:54:33 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b135ee722sm1172899b3a.11.2024.07.05.13.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 13:54:33 -0700 (PDT)
Message-ID: <9742abda93ae2d90148f54b585adc825e55a1a38.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: amend for wrong
 bpf_wq_set_callback_impl signature
From: Eduard Zingerman <eddyz87@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Fri, 05 Jul 2024 13:54:27 -0700
In-Reply-To: <20240705-fix-wq-v1-2-91b4d82cd825@kernel.org>
References: <20240705-fix-wq-v1-0-91b4d82cd825@kernel.org>
	 <20240705-fix-wq-v1-2-91b4d82cd825@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-05 at 15:44 +0200, Benjamin Tissoires wrote:
> See the previous patch: the API was wrong, we were provided the pointer
> to the value, not the actual struct bpf_wq *.
>=20
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---

Would it make sense to update one of the tests, so that it checks the
specific value put in the map?
E.g. extend struct elem:

struct elem {
	int answer_to_the_ultimate_question;
	struct bpf_wq w;
};

And put something in there?

[...]

