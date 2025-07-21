Return-Path: <linux-kselftest+bounces-37750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D602B0C519
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 15:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34AD0189CC51
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 13:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAE12D8DD3;
	Mon, 21 Jul 2025 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i7Af87Rl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92732D6607
	for <linux-kselftest@vger.kernel.org>; Mon, 21 Jul 2025 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753104325; cv=none; b=KGNGhR4yZ3PdDj+929Ko1U/a+O5uDFLiAsHWgwZExkElBmgc8V5TzpM85N2FQC73PLXr7VXtOVahNEvSsOwBSodl6bFBfaYkvVloGozaNHpL1XE3ZgZliRXlf5WCKS/VqaKvXwXLai+N5nb6Wa0koiP6rXkuCudFOMkzCwbEMqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753104325; c=relaxed/simple;
	bh=UIGaP2WMgsKajna8R0R2j3HUDLSthHfOLtrl0z1bpfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SiYf9o01lHK+r2MI8s25/TChbzMaAT2F0r7MBsO5/PHuTdM2UGeG2J5AmWvEZqk4iiGI3xhAwfZTvG25FKaxAS3nVTuKbxxBVt0RIWvgAmwRQJ3umHPxWj21295YdlqTLr03luqiz5EtU2msViSYJnnUIhWGo6GJQ0nzek+yRR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i7Af87Rl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56L9nI5S000995
	for <linux-kselftest@vger.kernel.org>; Mon, 21 Jul 2025 13:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rZQHynXS9Aj+ofzqFulsvS4teiqfVzJDlJMHSlRQVic=; b=i7Af87RlSsyPtyRr
	HrR0kGeh9hBMhTS8D+mPtI2cUrZ6cZFvfm6WqrUYS9Lgng9+sPvqV0ogMQKwBuZf
	h+z88asJNbJ/WqxDZZloocEJ+hJyjC23vnIIV0IJPY5RQXT6SPNwAQO9jJBPFLYo
	3Q6MDy2LOp0vidV8nn3ODILDkEbq3J/wB7gz9TTXsBmeCV2WcYt7BYNa3u5zF4Z9
	eUdRlsZNCVI2SA50hRM7wk6IX81r25SPRz5A2ykwvTMQkQdc03t9MKcKpxqtCe7U
	yc+xa3PP7yfNN4RgoyPomX+v4r6wAxjMr1MSR9iT8OnEK1MZ5CiStaKJu2OLtz8L
	koqCgw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044dd78a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kselftest@vger.kernel.org>; Mon, 21 Jul 2025 13:25:22 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-75494e5417bso4004528b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Jul 2025 06:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753104321; x=1753709121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZQHynXS9Aj+ofzqFulsvS4teiqfVzJDlJMHSlRQVic=;
        b=nOMgVdHorVVCH0PAhkGFXTVxCWH8oJhiqtv6jq8FXpj1nGp8pHKC7Do2KF01MzIZj6
         xgdhoXHx9V86HezgDwoLj89Uo0OBt8rHq++ZVvFR1iZ9ogBxaC0flEJG2D1ZgonLxdSM
         QzalVIW+kj/DRLx0UkOCSuHYKSuOGB3zoz7SwB+eK9HhMUaRl6IdZzuJLGXFvvlQkKaA
         lLYa/FHEeuuwsCrxVQMj/oGlOmR4mNmL0l6NaufBxoTBR4eOCwrskyiNp8LfMFbie66y
         Y4x7EU5UO+kZz+6/ryZMDGXCQ3VQdOPqbf8NmlXvDnq13lJ71XzTdWqI0iNUeDUNTVRG
         PGqA==
X-Forwarded-Encrypted: i=1; AJvYcCUgIE0s7bhjBSCqjrJiz/DXaa244EcK6fFJTpzsqM2wL747IqvOGjZYdZRjReArwgi7HGS89ZQbY83+s+Blw4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNvhmDEUEW65zZiiOBoYYhmV9aihkpajTRivxKTzcYLUTMeV6c
	5NQq3HsiqP8RWcheyRUfb9YS519Y4FKzc3fwwCQ1L38UjSwq0al/lAjzDpKVIwFDlYnNzJKWDkO
	hey72KeXFWKJpil6fskcKb2jlfmNkaSbKxNknpwFcEGAwGoaRu3tN4fj7DXS6mKnwB+SmgyA=
X-Gm-Gg: ASbGncuRm8cZwTfj2tQjK23IJJuQf9Jz3lnJkjWNG5xMclLoL3VNnjIYRmO0HzJm5Ew
	ZGx2Xwp6CxOIj8KBLGn4HDLhy/wMc09XCgpImIglOcHLrCKSI4btpUaownkxhToZHpAoyXFp54d
	L39TwnT14BeQctpD+YRRl4xNRf0dQgV+HqoQmyeUT6HxuL5vlOMv4SyhOIQkIimLj+rkzjuq9SZ
	9yP2ncfWZTK++GUHsGAVSY7OP+ZiIK3OY5X2pdVEcRExycvbWdbsGY/QbIZ7bQ4Pb9N/YEWn7N6
	rUIiQ1MvVLNbKhDW+BmqbBQ=
X-Received: by 2002:a05:6a00:440b:b0:74e:aaca:c32d with SMTP id d2e1a72fcca58-7583806f7c9mr22318745b3a.10.1753104321183;
        Mon, 21 Jul 2025 06:25:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVAG2MuKiinbLb8Q53VUsMTuw7REYbjlHCJcq0ez6hDk7d0Yrje6e4GNuTCOXMv94W2Rtf2A==
X-Received: by 2002:a05:6a00:440b:b0:74e:aaca:c32d with SMTP id d2e1a72fcca58-7583806f7c9mr22318689b3a.10.1753104320687;
        Mon, 21 Jul 2025 06:25:20 -0700 (PDT)
Received: from work.. ([120.60.76.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb76da69sm5688821b3a.115.2025.07.21.06.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:25:20 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Shuah Khan <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Niklas Cassel <cassel@kernel.org>,
        dlemoal@kernel.org, jdmason@kudzu.us, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kselftest@vger.kernel.org, imx@lists.linux.dev,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v21 0/9] PCI: EP: Add RC-to-EP doorbell with platform MSI controller
Date: Mon, 21 Jul 2025 18:55:05 +0530
Message-ID: <175310419611.11873.17918717791350182486.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250710-ep-msi-v21-0-57683fc7fb25@nxp.com>
References: <20250710-ep-msi-v21-0-57683fc7fb25@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=687e3fc2 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=5oemJFBbzWj47VPNxq3P8A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=mrIX6-fznQKVqVjsUugA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: 0_3vrtxQhglz1exoxnqZJeQXXBH_Mfzv
X-Proofpoint-ORIG-GUID: 0_3vrtxQhglz1exoxnqZJeQXXBH_Mfzv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDExOSBTYWx0ZWRfX3eTvcAnW2CnX
 Uzo187jXizksMywXswXe3I7JRYL8J2XosEuaeQ3MoK8liGchw6p/6TCysh8BkwHFOOSxFsgrw/v
 8o0j10CDZjxksXlvGqMkpZBMbahOqqlO39OA/lPM+0eEn5AWM2HaGs7LH6vB6CHZRk8Vt7tEIzE
 O0JSUwkTlFEHhrRgCMPBkRRQnWcWnL+ETaDMbRJvAZ4Qr7ci+tauVZfqxaRIUua/D3l98SeEigY
 ByRTb8qZeDXnHos7/pt4G04z9yOSjx/+PyU7HVrSo7CQ1VXvnPWEpqfkpYRhQ5Cl1SpBPVPzhHN
 eESvRMVSjqOoZnAyL7UiK5Cu11gG251qHeAeTWJe6INfxeihPmz4FGXZsrhGTDH8TKcvmB4Mn/i
 GFhgJ6TUBYhT8bI5SBpEGindGwdVTrUWZxeqmMcySwwM85ESjDesEOatAruGlQ5lKJeOdWY4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 spamscore=0
 mlxlogscore=942 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210119


On Thu, 10 Jul 2025 15:13:46 -0400, Frank Li wrote:
> ┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
> │            │   │                                   │   │                │
> │            │   │ PCI Endpoint                      │   │ PCI Host       │
> │            │   │                                   │   │                │
> │            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
> │            │   │                                   │   │                │
> │ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
> │ Controller │   │   update doorbell register address│   │                │
> │            │   │   for BAR                         │   │                │
> │            │   │                                   │   │ 3. Write BAR<n>│
> │            │◄──┼───────────────────────────────────┼───┤                │
> │            │   │                                   │   │                │
> │            ├──►│ 4.Irq Handle                      │   │                │
> │            │   │                                   │   │                │
> │            │   │                                   │   │                │
> └────────────┘   └───────────────────────────────────┘   └────────────────┘
> 
> [...]

Applied, thanks!

[1/9] PCI: imx6: Add helper function imx_pcie_add_lut_by_rid()
      commit: 9d0ca8df2451eb66a0c13a9932f348d417d9603b
[2/9] PCI: imx6: Add LUT configuration for MSI/IOMMU in Endpoint mode
      commit: 234b9258c6907cabbb2594ee366286d35ff056f3

NOTE: I've dropped the Tested-by tag from Niklas since the tag was only given
for the EP patches.

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

