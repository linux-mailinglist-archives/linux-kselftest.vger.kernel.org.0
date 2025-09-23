Return-Path: <linux-kselftest+bounces-42143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BCEB954FC
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 11:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6681682D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 09:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9223320CAE;
	Tue, 23 Sep 2025 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gbhK8HBX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4058F28850B
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Sep 2025 09:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620873; cv=none; b=i004Krb3VKNBgO/8FHeLL9mFbguPq9liNzrLEdbUXl+RxUJ0K+Th2tP+K8TNDEJwbGwXOvBuUW0dr6dzBySSAI8jIrgXhc1eWRPkMIrMC+HeNtQRjkFCHOJHXyGQZRhvwRpF+5jiAq9Nn44EzGKV3MxjDsOKYxxDVK5baR/I4eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620873; c=relaxed/simple;
	bh=6NephiHlDDWZjUDgQSNZd+O1MAHNoJ8Zj4QSD6tMBlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=piCNcZhJKJ2ClvZrWXda8EBN1dxwmZGA/rZqujusGwyjSuov0zJw644yIixcnrJw3xjIT+Wu/QqEMLNT6GqcGcYlyeAjf6p6blvgBTAbGpefSk6A26R8Ml04q/9D95po9Ce/PpXT3z1zYRBEL1YWpjm6oh7OGeR65y3337WU7BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gbhK8HBX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758620871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X3zbNBHZeX4u7pe1g8MFTz/QKax3NsVn23uV23hW5+U=;
	b=gbhK8HBX2nOehsBDyfiHcRk4HfUZ/J0RNYsNbJ2c4LbNuUZuc1333p9XG7+qGxfcQGYmrb
	QOuVwHu5biHZM+VocJ5OQd0yH2xLJwBSMUgo4sDqnE8zeuoCqUeHFzCJ/2ih1vq/gnwnNf
	j2RJ4fStJE/y88gdggzl8mvBBsrC3XY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-Na0miEhpNOCO0l-2U0YjDg-1; Tue, 23 Sep 2025 05:47:49 -0400
X-MC-Unique: Na0miEhpNOCO0l-2U0YjDg-1
X-Mimecast-MFC-AGG-ID: Na0miEhpNOCO0l-2U0YjDg_1758620868
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45cb604427fso29687145e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Sep 2025 02:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758620868; x=1759225668;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X3zbNBHZeX4u7pe1g8MFTz/QKax3NsVn23uV23hW5+U=;
        b=T8JZZYtBNT2cN+DtfJ6QRkD1DvmkbCeyc86yojUJFuT0JIKv0x4xuue0k1SudPdsUX
         zMHPqO1wnjSz9GvJWe9ybHZtiavZSFBuuGvGKOC2ZRzPbyrXl4a6aTKxQBWUTeFvF5DD
         F2DCuFuqKzxTNFs8aYXkwbnfQsbQUHdl9fVlO0dmBFvnRFRa0RLYf4rF1Dc0xqL+rSyI
         oVAw/QCFX346Hs4HJniCoyeJHKFEA5IryXB9A7nISnSVm7rWvwKB5Av9oiK6mF6AWqeP
         DT/Evtp5oY6gMcPT76Q8lCOIsmVgSw4Ayztf9Yv4Yzp7bP//VWhpDDjcCREO0NCx+Mnf
         HcHg==
X-Forwarded-Encrypted: i=1; AJvYcCXUSNLsCDVnAgoZcKTuRNtlU23wQrVC9o+xWwKM+BJ86UuIRszhzGEz7DwgQ5b7tN5eolUiqAip+Xbi4tnjfX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn8Q/m8nrWeOIC2hsxe7ol4wfU0iuL8an2yHPuSX32lDlicMgU
	3jSNr60pBMNNeCEN92by7stdzPpfnFHJDRCaDGo91drSMi+cfEJqMB1uKy01CbRUSv4ofqpi+Eq
	vVbUgr41jpO2j4DuHqNWSfEI2TN4BHksb2iNQyg+TDDUkJJprmGTh4OiCuMrtCFYZdv2YBg==
X-Gm-Gg: ASbGncsIrOnrPOyqFMbGbu/y8QEn+XyoIWBZKyciuwA6PGiHTgGuXk0cQGnoPlrrUof
	a1IPK7n+i6Kgqsu+T211BOlYu785WQ2ypdLoq1eidLnTkTtIftR0A/tFmaJe/XnH4lNOvv9UgaC
	x+S2GxBPatpsFIutS2QB3gd/jmr1PhlQh/l4X1wiDt4lPjmRLk2A3K+rbFGolwXzbdT+gcGfKYK
	U6dRjEclC7YZ0xh/5m3hLXQ4IuldMbsv/9Qw8+1GafgQ9WEqd6YOZIk06YExXIpcCA+PUmg9+O0
	gujlTbF1Ox9xUxzl8KGcWWzamzcVFpnE7i6ruEdwue4dCje3lXJIsgtBKeffgl/NgWaxyiHuLR7
	uTahQcj7cmLSY
X-Received: by 2002:a05:600c:4692:b0:45d:d609:1199 with SMTP id 5b1f17b1804b1-46e1dac9639mr18916365e9.30.1758620867708;
        Tue, 23 Sep 2025 02:47:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEejj73xYyvJhtG+80Oo+hw9FL95RSTSMEQ7BHTRfIVzB184Xe9dwz7Q3l23RiwZ/8pTX9Nhw==
X-Received: by 2002:a05:600c:4692:b0:45d:d609:1199 with SMTP id 5b1f17b1804b1-46e1dac9639mr18915955e9.30.1758620867259;
        Tue, 23 Sep 2025 02:47:47 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee106fd0edsm22603388f8f.53.2025.09.23.02.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 02:47:46 -0700 (PDT)
Message-ID: <161c09cc-9982-4046-9aa0-d0ec194daba0@redhat.com>
Date: Tue, 23 Sep 2025 11:47:44 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 03/14] tcp: accecn: Add ece_delta to
 rate_sample
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
 <20250918162133.111922-4-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250918162133.111922-4-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/18/25 6:21 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Ilpo Järvinen <ij@kernel.org>
> 
> Include echoed CE count into rate_sample. Replace local ecn_count
> variable with it.

Why? skimming over the next few patches it's not clear to me which is
the goal here.

Expanding the commit message would help, thanks!

Paolo


