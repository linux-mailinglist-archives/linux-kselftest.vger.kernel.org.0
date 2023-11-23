Return-Path: <linux-kselftest+bounces-472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2C97F5983
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 08:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598EE1C209CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 07:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916D6182C0;
	Thu, 23 Nov 2023 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o4L739+A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4312E1B3
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Nov 2023 23:42:54 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507a98517f3so700314e87.0
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Nov 2023 23:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700725372; x=1701330172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=At+FPC018DKf09p2RSe89eFy4wA5oTJyOpytMU4kgIU=;
        b=o4L739+AmdJB64pyw+JMVRlGSpYRDtjp4sEo1+fokZdYxGG6Ugx4r4h0pk8tYRGRt9
         sOe1tHl4eK7GwGenYZ+0aTUFhSE1c8IHMBLwPJfOHIBqSN1XN+/hKliWgZHf8oaa6424
         iRWI5F7Qzg7eC48YAtuqueSXIBRra7WD3qXQhNiMLo7WJmNHQGn2Cr1WSsXR/oPztWIg
         QK0TJ+kWa6xOShyxtgxmEIZZiXclhlbbf/jDHDNF/r2YHek5BqQM6L/x5T+ucLFN6E0S
         iWx1DFSrOaTumi6bf2rbibi03bKOfXlV77te2SJkSZDsoQa59ZSaQSQz8J0XRPwEoQdB
         torA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700725372; x=1701330172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=At+FPC018DKf09p2RSe89eFy4wA5oTJyOpytMU4kgIU=;
        b=djEH9Nrje4kxsejgXdB77CbNTqqWfDSHp8DhLleQKffeBQGxrdJpOoujo19EnGZorQ
         ccbtgFz79h2gwF6LEESuiufm3ubtWbZW1vmNL4N+hbBLmtHujFTu4Gor8lWJbQbUatqx
         cDSUnEy+lIQU0jIKA6yr3Zjr3+rvrY43L0c9P0mdpI5VPk0PJAGKxK6qCHNz3p1NuQI4
         2Diqml152wAA6ruVPl4GwRWAJhESDEq1RZcoLxSpbPzzsY9uBd/KFgS1si7Edn6d/hBp
         z6F67BRdKc+UTCoU/BT6CnYLBd/ljBHM+KmU79epxQMfpj3T1CBubv4TvzvMjq/Ku9/y
         1zhA==
X-Gm-Message-State: AOJu0YxhjKiv07FDNNeRUYwLPn9V3ReqTnRv+o8fHObpwpCBzyKn69a8
	52FV03ZfXmpLvlbnar/l1CKQYZBvOp45+Eb3FOg5Cz3f
X-Google-Smtp-Source: AGHT+IEmrDJrP/QqVvs9kKyFOG8bQT6cUA0NY7xxSAVNu7mEpFpDXFlPuh7l4xd1U28wFHj3LaJjTA==
X-Received: by 2002:ac2:5f43:0:b0:50a:a82c:a5f2 with SMTP id 3-20020ac25f43000000b0050aa82ca5f2mr2678724lfz.66.1700725372471;
        Wed, 22 Nov 2023 23:42:52 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p18-20020a05600c359200b0040b360cc65csm1062105wmq.0.2023.11.22.23.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 23:42:52 -0800 (PST)
Date: Thu, 23 Nov 2023 10:42:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Laura Nao <laura.nao@collabora.com>
Cc: rafael@kernel.org, lenb@kernel.org, shuah@kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kselftest@vger.kernel.org, groeck@chromium.org,
	broonie@kernel.org, robh+dt@kernel.org, kernelci@lists.linux.dev,
	kernel@collabora.com
Subject: Re: [RFC PATCH 0/2]  Add a test to verify device probing on ACPI
 platforms
Message-ID: <4f1283d4-1c50-4aba-ba54-b9ea975bf61d@moroto.mountain>
References: <20230925155806.1812249-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925155806.1812249-1-laura.nao@collabora.com>

Your talk was interesting at Linux Plumbers.

https://www.youtube.com/watch?v=oE73eVSyFXQ [time +2:35]

This is probably a stupid question, but why not just add something to
call_driver_probe() which creates a sysfs directory tree with all the
driver information?

regards,
dan carpenter


