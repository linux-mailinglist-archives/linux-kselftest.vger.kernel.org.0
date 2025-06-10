Return-Path: <linux-kselftest+bounces-34627-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B60B1AD4590
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 00:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A6917DA0A
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 22:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5514D28AAE8;
	Tue, 10 Jun 2025 22:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmG1vNiN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C4628A1DD;
	Tue, 10 Jun 2025 22:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749593025; cv=none; b=Kke8pJS5lZK3uhKOdKc5OauBfLwRIvEdZ+pusqd1MjDcRAQ5id9VfUXJPxhOrBXWGEMjfjPNP+5Y2nC0ZBCjdwkTaXsJq+fd2Vzhq+/UtZDmwcU137HjRi3l5joDiLyfSXXbPvENkon0RvRxngaYi2XDNkAw9PWOkNq57lP70J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749593025; c=relaxed/simple;
	bh=oxKec9aTDlYmg0HLbGa+lyFHsnNX3sd7Cx1P/oOxt8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKUqPT+oOsaPHWxAvzrAJ4C963cy3uIWVOdRAa4WEfrE77sWtLtKW8Sou6Tsl2OcIZcfoHGKRVEr4jg6RWlfytUaI5f1m6BDi15YhpoWJvVe/bZQVM7Y2lfOeBJ8p/D3PRcUa/n9TWrO4GpAZEa+jrvMVEnjUaztnOOlkRaAdqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmG1vNiN; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2e8f394bb75so3434100fac.3;
        Tue, 10 Jun 2025 15:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749593022; x=1750197822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EczlavLIRd1Z7GDaXRstMPS0Oc0Bcp8aSL0PIMU9kJo=;
        b=FmG1vNiNF70MdkaB736cR4w3eH0kZyxxxcS6eXQk4eazw/EIv7iwrkizk7WCzdk+va
         jiYEemGev8szxnrPYLQ8kGmIBvqvTabQjYzmHf3vuxCHUesnMzWJILs3gRCP24fVx87Z
         gPOyazs9qtda/uXnaHg48Va+HszW58SByKa36u+7btx3PuTqb6cgzwrrKZvXiQdAdHNu
         m5UgGLyZLL2PNYYcU57RGyGLXHlYdD8JLZoqWzT7mTlQZz+TXjSbxRbHP+usV1olgs8R
         Avv6oSfD/2xSiF9HuDm1yaxLGMCFRhnSW8djIqpPeI0Fp2n99IGPkRya2Jb7xyoIJEzO
         P/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749593022; x=1750197822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EczlavLIRd1Z7GDaXRstMPS0Oc0Bcp8aSL0PIMU9kJo=;
        b=SyH5pTdY3GlzUUk/vMtoT/aZSnG26DAcVcfHHifKnJThJHDrSAgR7/yuzUq/KmtoQs
         bfClAE0CL3Jw4jGaVXOXXmdr5uuqAtgREfRZhBdy/wUugsXcVcZ/y1CRHTsXsfpeHzq5
         hNnmPJzGPFUKWZKLBuNed9kVSKRDHlM7hkCUp99f5Kygsi/OP9lfXh6Q0OZWdEmpPzXD
         On2RHfDLeiJHhZUcIztYXXl83x2v3G+jwHZ7EQAMK0ugemmimn3BaVqdZeTBx8iqT3xN
         Sae/KDd03RY9LBeVSTThcCFuCnsztarvUr5tnHxx8iwj7pw4c0ApuIEr3mZJaeja4Z0Y
         qytw==
X-Forwarded-Encrypted: i=1; AJvYcCUmMwKh57OJBVe5NdPd7EIDubb0vuoIEkf27FD4LfLOtOFokWFTHUtAtxf7uCN58cRSZ4Iu2A4KXUcOcCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaR2FVUkGwdgqqF17gsTnyr6Zbj0ZhLcTQN8EWmTzukOlfe6UV
	2pwUe/3dy2J0StsTA44CeW5v89sDvQOXssHS4wM8y0nZkbbITZIuxFa0mQG9GA==
X-Gm-Gg: ASbGncuJp0G8CXsh7awuqDZlt4waVu79aFY9MJNXzMzIiS1T04E+8rRrxnguNVCz9aN
	zhYNds/xJtGjzeEhTauH+K859B3JebGx74j1tYWRaQgUJiKWlL5lRiT1T70BU4kMNxh2C3GwfDb
	01fwLTdUrg+Qs04ib7Znn6CmMCJkm3EvWFmqd5KHx9M1Py7R4jZaeso+e5OgzRlg6D7da/v4+pE
	PLXNsuuCo2QzOiWpDiYxuoLdyO4WaSr8SNwLZot9Fo8kaDlGlt7ZihfTFil0cHUrjlPs1QICK1N
	IEzmgUyjBNJ3NBgWck+mLDYHmosg7eAzJAFR6MtSOsHzG4bp2HtS6w==
X-Google-Smtp-Source: AGHT+IFN5acX0KX+9t3qz5TRwUPXDGWfGQtJv57bEsW7AExqKP66GjtucoDB8q7hl7w8owZC/IHZoQ==
X-Received: by 2002:a05:6871:7293:b0:296:bbc8:4a82 with SMTP id 586e51a60fabf-2ea96f113ffmr681031fac.27.1749593021482;
        Tue, 10 Jun 2025 15:03:41 -0700 (PDT)
Received: from localhost ([2a03:2880:11ff:57::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-610ef763098sm56645eaf.28.2025.06.10.15.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 15:03:40 -0700 (PDT)
From: Tianyi Cui <1997cui@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v2] selftests: Add version file to kselftest 
Date: Tue, 10 Jun 2025 15:00:53 -0700
Message-ID: <20250610220319.405806-1-1997cui@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <328326d7-a72c-4fae-bd39-af4d89666a91@linuxfoundation.org>
References: <328326d7-a72c-4fae-bd39-af4d89666a91@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks for your patience for review! I've updated the patch to make it
easier to understand. Specifically, `stdout` of `git describe` is stored
into `VERSION` variable, then write into `VERSION` file rather than
print on-screen. Please refer below for the sample output and the
content in `VERSION`.

```
Emit Tests for drivers/net
Skipping non-existent dir: drivers/net/hw
Version saved to /tmp/ksft-net-drv/VERSION
make: Leaving directory
'/home/tianyicui/test/nipa/net-next/tools/testing/selftests'
➜  net-next git:(add_kversion) ✗ cat /tmp/ksft-net-drv/VERSION
v6.15-12423-g7ebe76e39b4c
```


