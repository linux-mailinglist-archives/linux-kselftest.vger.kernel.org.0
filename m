Return-Path: <linux-kselftest+bounces-14869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB349494B8
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 17:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDFD9B28D29
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 15:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2634C3BBEB;
	Tue,  6 Aug 2024 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nD1rtHpj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s91TNRrO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C8E1799B;
	Tue,  6 Aug 2024 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958716; cv=fail; b=PaFZhn1yo7WdaJSisDUjTidzWmp9MNNvuCy0LVzeW/JNCofV0KIRD2/u1CPL3rtvcWZsEMxAaMF7D81HzuWFcqO8UUQlAXGzQVGc/kIzrWQXsq0YaofMn//T9Xkb1FLVFVg0Uxi2ndFF3ca5z5Xw9A3u5N2saGQJ2r/1MbgxtiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958716; c=relaxed/simple;
	bh=a6USTozOOk4ibYusmm6Puwl18qksV8SbIIp78SZ7XBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O9AcsYP/W2yjJ6oBdINNJFAQ9TU96j0NYYNpc93xk664qfRn05SgfGYOKZwoX11joS7s8zYhwfK3b06tPDoXYFfo7tE/WennBoFv1d8G/Zz4Dza+PKJkLTqIKLYEdrdCX5x2VLR6qvFNb1SQhICy+a/b2YrpHLEDH8OaajLk4u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nD1rtHpj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s91TNRrO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476EWjqn006002;
	Tue, 6 Aug 2024 15:38:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=QNakxFB1cm04kNOyVqQ+Uuqbdo8PfCWEd5SF7Z8r2Ys=; b=
	nD1rtHpjoOZ0AMi76PB68i4MOkwGTMs+RzTz5NaVr4cpezkfMoEJqAPSlYYP5tdf
	Bp4XsxR+lukS6DR1nGqxbJo3gr+rjb6Ey8V0jHRsLl/Cj8UY+F7bHBYd9mpG+M5o
	lyQBKkVm8DzG3UNUvLIPPnamMIvrc9emaL3VC2lDQfaDMLZya2shmAUA0WQIddiY
	PrzDUGFytVUK4YNtTQZh0B2CWfV0VYE4TI2M433RV7lLOl4sB2GVCm06uVSjHino
	oitN+1jg1MihQO0smvzpaSp2qU7AU0TyqzxmcAUOEZ3slKAhylylTZJLYJOT8hqM
	cM9FG6euSNu6jf11CCRSSw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sd3unm5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 15:38:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 476EKj2D017641;
	Tue, 6 Aug 2024 15:38:30 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0a4h3b-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 15:38:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWiXTdAYornmY0J1h2J2DuZ17Uh8T5Tpvi4Nh4QEsNtvjtTzpASL3053pzyAszP3Q8yFgTU21zhA6NBlguivLKk9dDRQsYGXPSP5eNSUNZTbZfvpnHwmNZsNStaty5Qhd5sqPjSj/GBmaBHN7yyyR9PmB5FvRaLns+9Uyx3BgYsaq270yo/JyOIMpcAOT6rhRPF+GhfYz6yrCIGNdRctwQ9DVck5DZbLLlups6kF/w3J/EoXScHJWGvWQtIk0nP7qvPota12g1PgBHd4lA4axc67o883vJvliuEnh3jI1oGYrv/UO2bCVo7z5r+VIHvEaeJKA4GLJXqte2pSd5ur4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNakxFB1cm04kNOyVqQ+Uuqbdo8PfCWEd5SF7Z8r2Ys=;
 b=IqPWdI1/CsQapeteRtIPBkoO48y6fajCeFpXMT/VZ87OgnaUHX/4QrYox0PgRkiGpJBDQHtlNgGzaN2mWrTgHUzaN4LRSVXsxOM7ZQiFE8TGYbP7To90e8ptK+V5s95Cl/cUCG1ZKVA2j/zmNIxu6sKSYNh67YJCyKagDK04BucMzWdSN8PKDcgKQH0mxK/iFr1VLgR1YqvNqR0dPdpEnHN+TXkqPQlM4N1TVmjK3eFuBLb42qaiogAi7CiFuAJc0zaibadIR/Mg4xvGN2sXLeJ36+zE+X1G6SDvyXTJIbIZiWKxG+JMRv8CRkljP0sIO6cJYO6yKTEATbKYIG9aJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNakxFB1cm04kNOyVqQ+Uuqbdo8PfCWEd5SF7Z8r2Ys=;
 b=s91TNRrOszkSR9SscNonXY8COQ9i3EhsRzUNoAx9/nhrVOxWp3AoSCOkH7HEPFotsVfNrmOBEHa72yWqDoU/W0gn/o8pge8mrG4CwgCW/dlE8CPk+hyxVl7yZxdZ4wc2eplCPZHIbVbIQ0qNEzUBqyfhxh/jDhAQ5NN/eGnWJng=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by PH8PR10MB6647.namprd10.prod.outlook.com (2603:10b6:510:221::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Tue, 6 Aug
 2024 15:38:27 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%5]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 15:38:27 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-rdma@vger.kernel.org, oberpar@linux.ibm.com,
        chuck.lever@oracle.com, vegard.nossum@oracle.com,
        Allison Henderson <allison.henderson@oracle.com>
Subject: [PATCH net-next v2 2/3] net: rds: add option for GCOV profiling
Date: Tue,  6 Aug 2024 08:38:08 -0700
Message-Id: <20240806153809.282716-3-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806153809.282716-1-allison.henderson@oracle.com>
References: <20240806153809.282716-1-allison.henderson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::16) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|PH8PR10MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b05038d-a942-4efb-9d74-08dcb62dd0d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WMjCJ2QPGpuhSIrYkBdT/RsaGsPdkROqkhNgyj6H2YUbARohkrOgTppJxIfH?=
 =?us-ascii?Q?BU3/LVSgDigvFpY0KLzJ61jkvURtJk3UR/Di7LGvw6yJmvtbj+70ZwQ+GnBU?=
 =?us-ascii?Q?5PF+O4IHC2aCxsYV6XIzzgHvzj5PM0lAwiBB1I2t844iaD3C4ko83SMtb/6I?=
 =?us-ascii?Q?mpAKsUSxFAhYbDtfmkeNWOGBkJu1vQFm70uzKUAkQ+axWqNrQI7X8we+2LEv?=
 =?us-ascii?Q?ga9E3nZv+iqYxK7pigIqWo55GrnP5Nt5689tV7TetAoZO5ODLFWgeXg7tpI8?=
 =?us-ascii?Q?8f97eTSW+GTIUgaWr3xfseX2q3VQwMdUpY/G3hre9JujwPpEqIaaaD9JG88K?=
 =?us-ascii?Q?J1vkMddt+MzAmpmlb2Xd8zQouA3wiGxJYjBjUVmSPFyvX2SekB4kTpzknNuf?=
 =?us-ascii?Q?LMrwW5lFHgbDhSNUIIibhSTi9RdHKOFnxBBzXBS94Tgs8SXgbj3zV3z8yb0k?=
 =?us-ascii?Q?TI7UVs6qvGBp8t9bT0/fZxuglczC4ckOaiHdYy3he6UFLdXrAHdNuRB8A3Fh?=
 =?us-ascii?Q?b0YVLdTYYBJRuxev/vCaNxbHZ0++9hP0XhkG63fuDhfHmqEe3yVjLDYza4od?=
 =?us-ascii?Q?U7MFFMuWVwwf00784qrEhXzOFVYt4lCleaQeJDn9d+JG5SYKT2qQUl6bA1LE?=
 =?us-ascii?Q?xQoPn03yE3s95uzjntj2AvvrokzyUIOxVxlmGDvAOWijEkYcyWvqFEQmJxOK?=
 =?us-ascii?Q?lMA9GDc4Bd5AKD9bPSVcyhoxOZM17oLAa9KdLX8NtavbhenVApbSHNQUh3bi?=
 =?us-ascii?Q?R/BHAnMO8IOi0GTJAs8AtU3FypO9pw5u+0ynnF2dQyLoVziz5FURM1BMkffK?=
 =?us-ascii?Q?Twu85qcEzK64fzZl+HuRTiOfZijCKStn3wFi2u7ZNS1EvYq8yib4bSv+pB8o?=
 =?us-ascii?Q?M704YaCI1T9ES9ouFEQ+1U5s3mtGSK4Ial5nORCjv8pcEsgy61XAbVNs7IH3?=
 =?us-ascii?Q?/kIRRfMR1xd3bcbP3qm3XCwVh2+RnLZPimIKi7s20JqKrS94TVHn8KTA2qF3?=
 =?us-ascii?Q?fUf9lIDM0dJZzIbDFuvjGjOtFKzlNmvp1Ay//LSd7RqMSD2bfxk7B1BWMbXR?=
 =?us-ascii?Q?k/BPLUTfgdjLBXjhQw3g5gBF5dPdRWt0ZvfhFJ4axG6trZ7COsz8MM2SeHLD?=
 =?us-ascii?Q?PgYFGwNbdKJ2+uephfejDMUy+tR0D/d+xjVilGKVR8yn4HFcg64tcSKQpBw7?=
 =?us-ascii?Q?R1v7s5+sob0mBSu7TaGQCU0CKOHGcKHPJzF8QKZO4pMUR6kbqq2RGbivI67h?=
 =?us-ascii?Q?W9n8cpVkUJur11xVfSz+gnA6vr1j5O3TXhdZzY2rATUt6eiGuFZDl2GwlcKk?=
 =?us-ascii?Q?fRXYnsbQE6hTyjQUT5Qls+JaIGvzzI8tKPsSk+XwkTuNiw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kCCGlsAQyLwFDnKOAGAsBiUlijI1CsCOj8zvsVsl6dLGjMfnMLJeQtqtco2S?=
 =?us-ascii?Q?gYGsjcf5ID7TjZhjlno2cVb4tRPpnASTdBs8bimzXlx/fbby80b1c9ksLnoH?=
 =?us-ascii?Q?AnmwP9k1HE4zKzvTV7tH9Xs5wZm+oz8Q59KlKlaU9XmOAAmvZNB6/cPCPVA1?=
 =?us-ascii?Q?7mRwPU560KnIUaM/09EcslFiLXJeDZ7S1m3PJTtBxTln2gjFy1ESQfkR294J?=
 =?us-ascii?Q?izXrldFxWf3/1vuU3yB1XVxPTajfIPjSX24Px639FGsEdQZ/xrNL3J62LfTV?=
 =?us-ascii?Q?vinaA+YoqqYnt0ztRkUcF1nS4TtBCI5sf3sLBi+9vYL/SDAjNBP5HFJHo7kE?=
 =?us-ascii?Q?DGjLxhvN+4cWnid4b+Q4AvUb6JRYuRqG1hTdhHX7E57pYh9sLmDGeNmGWgzC?=
 =?us-ascii?Q?AMJ6438FICbFd8ZMvzfvGBF7ykPGK4UhsEn/pO3I2eE87ykbCCzyxvRZhukL?=
 =?us-ascii?Q?Uh6q3AvzImGw4szAWcqmPy6/N5uA6hoXBEWjqSbTWoWmW2C1CA41D2+OnusW?=
 =?us-ascii?Q?pS42rA5USM8H7r2YUdVeKPH/yN8Rk70ld28mZ/Asn5bYomPDFyhAXR7kRRED?=
 =?us-ascii?Q?54tUcrTE1+wuHyr0Eak/ncn/wJinGFPOD0tGNCZT8kdouhaukhmVe+U+E+YP?=
 =?us-ascii?Q?lh+kayKtwhSdfdPFR6MPihm6qoUsoUPWl7NgCm0Z6UOLVTwD9HfuJplDUBwt?=
 =?us-ascii?Q?ZP8fcpJVnNLwWKHS4WGN3nWeBu4xEb14OC8vVTVceKugWIax4bhU0x5FcDJD?=
 =?us-ascii?Q?8VJvWZNUDOLCat1PHvA3WIaiX6+TxUKdAQBy9EiS2eHvv1xqSDy/R1yB81uM?=
 =?us-ascii?Q?3D8hJVJL5CWxFuT2egpUmAj+YBmd8sd5Ak2vi7JK4psMR3pGQrFOVdfVyPsD?=
 =?us-ascii?Q?ALKqppvb5/iUshb5Az7Hp6dRyJOdGwjwn/oIbWWMpNq1LtvNDN4otlKhcIeC?=
 =?us-ascii?Q?X5L9auR1Gkr0IpKWPxXI7s655XxBebS4keAR887pgt7ywogl7aClPSVhtdbH?=
 =?us-ascii?Q?s0Sg2BHdTgFQ07MpJMZipuAP3r1RUFc/6C3lCV8BjpHhGpFh8JNIRm9jBn8C?=
 =?us-ascii?Q?EFHKusxuoJ2p9HScstwkgA/+BQOCgZec1DJs46H9/NHjBriuDj0E4D0paAAd?=
 =?us-ascii?Q?m/EqvpZdoMQ2/oXfCKMPzTM2cBsoD6lhCmmx66LwvtxDLR/qXRspaQNqOqgd?=
 =?us-ascii?Q?eguUsYBURTTnonsU3z6cj/RkMOBmYeMHxI7prPlQ/4RaY0Wbt5Bu9x2g1QBl?=
 =?us-ascii?Q?9/mg4htPTBuWb1LEbw8iEWDLP3PebEnsDwpp+UW1PWQHlNSQ8RnGXrDLpN0b?=
 =?us-ascii?Q?SI6E1dOt8wCY9dQi9w9hHQax8gq404sU17fqwSZ941DabOmM5SGRuc64ggLC?=
 =?us-ascii?Q?YkC/F7tPV/VRKeeBSJtYPI/+DBYpcgzMPMXchPa8vAiWztsO6g7bLwQTXNct?=
 =?us-ascii?Q?2xGxWQsPC/xY2NWg7y00hy4vHnqKTnQGgtTUpbLmThp5HMqC3dCn3TY77XcW?=
 =?us-ascii?Q?g22ez47MTPlwc/tHMfBTLFYP/eMBXcautq0SEFZjug5C2DrDUpRTpW0HEXwL?=
 =?us-ascii?Q?+MqUZrkBaHmmPrVRDw9qFGxBXEQh0tpxep+/xtgIkmF1yzZS0UwpkggOlwf3?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	95vzqBEyQc5OvjKL0rot85gBDRBmEhBGuFZL/CIpzmh+68jadIFdxOgOY0Y3QAP57iWOp2hf2AyBk4hU1icJGdLOGmiluBWfxFHBlrSB4emN85zFT9gYMuySsG+2bLx/5eiTVe8ZimS+vS8oBVMwsIlVWULd+ALSFHl3gGZNoZXPIFNd600L7K5xNk/hCazJP1iD7N8LMPuTHIqcrrhlaPj9ReCkZquy9+T4dg5MAvqN7bRMrClLkx0inIH6/S9qbeBNKLFq/+vioukG00yHdL1lJFjs8g5GRozvxrd6hiRIYkk2S9V5ucYBaKFuZ7CvKGnH9S2nIb8j7aXbHjk5tNiQ59qUFv/qRQ4tU+trRILPdSA1FRrqc6lotyU8xcuYj2G667wlt4ERHvobahMsk42bCwmsyLvqPUAIiw7C/hETMP4CoGYpYtqBBumA8FPPLFiUyTBb4dKNtplaUQOhzYzPU+KKRsi26+HkgxNfUJmDE8l02i1duy6f9MzkmoH5ruaPk6V0nWvrvpbDcKmhOcaAPeLZStWIkjDYBOTOsgag5KQfrl6Cvoh7UyxMeekp/zufvr8eTqAB+bSC9fOUtExg2zeKAKfoE76RdMeQBRw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b05038d-a942-4efb-9d74-08dcb62dd0d8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 15:38:27.5092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Onot17nKNjJTpJ2wXZcHY77DtZjGO7BKzKqAMQbuAxTHmk9e9IW1+49Fa0q4QtW76cbyz1DGaH2dn8+u6AhO3HV8LES1Y9nU65gb7XeGkIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_12,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408060109
X-Proofpoint-ORIG-GUID: J6WuVsZjMW2D3TKuBby0jBKN6-zZ82XT
X-Proofpoint-GUID: J6WuVsZjMW2D3TKuBby0jBKN6-zZ82XT

From: Vegard Nossum <vegard.nossum@oracle.com>

To better our unit tests we need code coverage to be part of the kernel.
This patch borrows heavily from how CONFIG_GCOV_PROFILE_FTRACE is
implemented

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/Kconfig  | 9 +++++++++
 net/rds/Makefile | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/net/rds/Kconfig b/net/rds/Kconfig
index 75cd696963b2..f007730aa2bb 100644
--- a/net/rds/Kconfig
+++ b/net/rds/Kconfig
@@ -26,3 +26,12 @@ config RDS_DEBUG
 	bool "RDS debugging messages"
 	depends on RDS
 	default n
+
+config GCOV_PROFILE_RDS
+	bool "Enable GCOV profiling on RDS"
+	depends on GCOV_KERNEL
+	help
+	  Enable GCOV profiling on RDS for checking which functions/lines
+	  are executed.
+
+	  If unsure, say N.
diff --git a/net/rds/Makefile b/net/rds/Makefile
index 8fdc118e2927..3af1ca1d965c 100644
--- a/net/rds/Makefile
+++ b/net/rds/Makefile
@@ -15,3 +15,8 @@ rds_tcp-y :=		tcp.o tcp_connect.o tcp_listen.o tcp_recv.o \
 			tcp_send.o tcp_stats.o
 
 ccflags-$(CONFIG_RDS_DEBUG)	:=	-DRDS_DEBUG
+
+# for GCOV coverage profiling
+ifdef CONFIG_GCOV_PROFILE_RDS
+GCOV_PROFILE := y
+endif
-- 
2.25.1


