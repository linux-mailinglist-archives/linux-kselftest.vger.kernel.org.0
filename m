Return-Path: <linux-kselftest+bounces-4389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D710284F1E9
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 10:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042551C226B1
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 09:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B499E664BF;
	Fri,  9 Feb 2024 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ny435h7C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="waXXDBC4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABD979ED;
	Fri,  9 Feb 2024 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707469580; cv=fail; b=C1jF5heo5mesB2PqEdztfNTXRSoU4vjbzh9fWbgTeDNg5TZblZHf3VeeF9O2ED/G4teeUbg2Ywz5q0hiZvHM95Z009BEhx3kfJDJQpFiep5lVl5IzllIp5HFHUzqrFwlJkNEJ000W65kZI/Q/VjNVBMdJmNKXtWwFvrNHp/qs8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707469580; c=relaxed/simple;
	bh=9JcbPWCwwM+ZxnKyFJdHRO/sk2ATmVjGKxBF/Fmjup8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H379Sdy3aFm6QOUniZ4lm1YOCyno42b7v2DLUd57+A3eQjMDxp7jxghWDGP4T5zCS2j/Efl+be438h7/u7fUdq6YGLdlRpysno44x+saH+Gr9LgRSuMQ9U1/NQFO+4XACnB7NT3g6fcrMNngEKnEvxIedY5K06ALVUnOxjEt4uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ny435h7C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=waXXDBC4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4194wgpA031876;
	Fri, 9 Feb 2024 09:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=gBniwwx+69S658IYO3S94aUPNtt2cxJQht8y1nb0aKs=;
 b=ny435h7C5Dp0vG3FNj1NWwfJH2mVVnUOWwnhvLtG6LBhaXcm5khmIa+NQHZsJ80Igq78
 /j+lLgjh7yf7a8VOhYG6WKFwZzUy4cU2ax9rtX7/SMdHofycvqefUM4+MV89ZzjpefXZ
 nIiIPNWpLtKNjYTwGFqbHV+Dd2hrFH1VRyBpINZ46kGKDNaAr3ow0hD92d1uHhLbmqvi
 NcvPgyhmg6w6Vj77gnMUPMc1FZlMCpNHTVX4jPe4aONunVfUVhLr7NLeBY4uPI0JbXiu
 rASLcykbUpZe+b90mxaz1Q4PYJSmFiLALzRBNVzhuwQ511NxuAwJK5uT76xCHwe6YGNE jw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dhdq0sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 09:06:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4197HRhj007358;
	Fri, 9 Feb 2024 09:06:03 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxcan2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 09:06:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHlyIfu/HImozMDiTuEpuTxJrrEbaOLT683xr8voIK8b4Zh7ZiQD81LvoGPwfAgrEoV3uBQqVtYeHivBzjlgp/3MVgUFDiL7dKiCWsQVPcSmwNZD+0BbzdZh0iMB12VzoF2SBRGp9srT1xTkBhumwXQv0YNgvQOzUtOXoWOAcoxkSXig9KfcJ+2pV1m8VJvrfRRas4o9DKiEjDpG0cKjXapL43LrTpNKprE8H+RGTIZZ8DC2Ddgth0a2MWMiibvD/aLkKxGyKKYNhWawYloh8VVgNxQWkMwyMQNoYXgCUwUzEmzNqXsgZp0RC9BrScxqwn2IXCoMPNwZQOd3zj6nPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBniwwx+69S658IYO3S94aUPNtt2cxJQht8y1nb0aKs=;
 b=lIkQX87W7sxw5EUBWmcok2wdqR/LNFr+VqPUdj6arrB25QUFhrH5jzcrPnJq0CkFwaFekvwwjuuHS3Dkv3dHajQhQfMm8i+CzsRxb8l3nqD3baoSSFy8LD5rUNOWFTw+4gv2f1cxeB/GVCHpTXXciqMbrPXrdqXttjsaemCp6Roa7Ey3gVVsVGesl8HSVB6XbKeSlV6C46siZoy1sFilFqDigbg4IV0/Z4vcYDWlycF5VQKsQ9k7V0Y1ELufOVJ4FY6o15kvmScXDEuhzovya0JqTpEr7fimI3qxaqNzdiwblVjCDDd2QKTl65ulFEwnT6g1m27SC5YrO3b28TZ06A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBniwwx+69S658IYO3S94aUPNtt2cxJQht8y1nb0aKs=;
 b=waXXDBC4hKJSawQ2oE8xd4vuhxsfP6TWq07Z7aKzLpP1YNRcJQalg/M6y4678ZIXYHH6lEPo/wh7J6pkQ56/FZ5CQO80VaFQkFbmR6w09zoIJQBM0g9x7aQSfsXfD4Pm9HhDN0Lw5caXwpHcluJ+A2uT0yms25EPWb5yLWkrWws=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by MW4PR10MB6324.namprd10.prod.outlook.com (2603:10b6:303:1ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Fri, 9 Feb
 2024 09:06:00 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3%4]) with mapi id 15.20.7249.041; Fri, 9 Feb 2024
 09:06:00 +0000
Message-ID: <089fd038-3019-4f6e-9a9f-47c1691a282c@oracle.com>
Date: Fri, 9 Feb 2024 09:05:53 +0000
Subject: Re: [PATCH] iommu/vt-d: Set SSADE when attaching to a parent with
 dirty tracking
Content-Language: en-US
To: Baolu Lu <baolu.lu@linux.intel.com>, Yi Liu <yi.l.liu@intel.com>,
        joro@8bytes.org, jgg@nvidia.com, kevin.tian@intel.com
Cc: alex.williamson@redhat.com, robin.murphy@arm.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com
References: <20240208091414.28133-1-yi.l.liu@intel.com>
 <43887410-6a3c-4d1e-b1fc-abb0da1a0ad3@linux.intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <43887410-6a3c-4d1e-b1fc-abb0da1a0ad3@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0091.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fb::18) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|MW4PR10MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f6edbc-ec80-4f8d-08d5-08dc294e5578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	81SXW8J1iRZhLwd0wVL9sPyezQfpN0lfGa/X9r9LFrRh/P9NqezDiJFvoJ2pfqSPkhIYj16IwVsXZtZsau6qjsfmHrMMxDplf/gLQHDe6lMCzSunNCBHaqsyvEeEdMHfftyZFOJlBBxYxkdxJJBb1i480Y4xIYEgb3KpUQURnG/1VibWTaA9YZfWUrre+LCnUn1jsJOsp4XtgTi4+sAiNqPSxaKaF1zW8GtamPmVSn3VSMrizY9ZAsZ+vsLeCCEC0Pk7JgVMqrKDYRKmRbGYxbD4VfAD9th6RVLLEqZ9TFphj0PATlQcdhhVATGEvsbTvFdQtJcTFVJFQvplblpP4ZJYmyC3IQRPm2tiUzBR66LlLAT5FMJUvRu2luCZBlFzNLDyDRMObD3O0kMtPvi968vALQ6soRxTg0KUpVX75YdKQBn+WTZy5uHXnyrUAmx8T4RD/mz5dBl8cr5nGLo5gnHaqqNjwFMrNWrIjugKs6geMU6dM1oVVsY2EWKWQWpd4qGgHKldFn+2eD2CqsBQfOhrj2xtKQHnsmhwyqiamUDvRd3YPvDLqdjlPHneZ8gC
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(39860400002)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(2616005)(86362001)(31696002)(26005)(41300700001)(6486002)(5660300002)(478600001)(7416002)(2906002)(66556008)(110136005)(66946007)(66476007)(316002)(8936002)(4326008)(6512007)(36756003)(8676002)(6666004)(53546011)(6506007)(38100700002)(31686004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?enlDRlVWaDY3aUozLzJ1TlU2MC9IU0ZMVERpd1pTa241Z3A5Y1MrSTY0MFpv?=
 =?utf-8?B?Q3NCdzNLMStObkNZSTFLaFFpOS9kZ3pBSEU5Um12YjFFTGpKb0h4UG0vMjlx?=
 =?utf-8?B?N2RKRDhpVXF5N1JDYU1kWGhCRjcrNDIvLytENElkb3VBTStFQndidDh4TVA2?=
 =?utf-8?B?bWV2VTEzbFVmeDlxUjlteENpQmZJdW11MmNySkJ3dU9hYXEwT09WUUcxdm1v?=
 =?utf-8?B?UStVUlU0dG1zdUFsUEJCSFBQbWRFZ1NGUUNUUUxURHhHSlJlUzZxM0hFOHg4?=
 =?utf-8?B?UHlwdDNibWRKekFpdWxsM2IyZG9UbzdMRSt5UjUrQ3IrNDc2WGZ0VTVmZUIv?=
 =?utf-8?B?M01OSzFwK2ZsWGlMMkVqTnFSSE9xZE5UeE0waWpuT2srTHdCMlFMREVGWnhs?=
 =?utf-8?B?bUd2SXc3amIvOEVIZy9JT0ZQUWpmZWxYU2RxN09Xay9qcEpPNW5Ea1R3UEJh?=
 =?utf-8?B?NjJqS0xoa3R5cXlVem9zNHd2WElXYi8rT3dhQTlyRU9laTl5K2ViM0hIUUYv?=
 =?utf-8?B?L3FPcmdGWnVqeDNxR3FRMG44c3ZMQnpmN3oyUFI1VUNoa29CQWhvRkI4THRl?=
 =?utf-8?B?K0ExSUhtc3dOTythekhuMWRnbS9seEdnd2VLZXJ2Nk9JUDJ5Z3JIOEZyWk5x?=
 =?utf-8?B?U25VOUhCcmRUUXBwMmdSRmVQQWpsYXRPRkRvUkRqeHN1UXU2VDFVUUsxdUZr?=
 =?utf-8?B?NEdQS2dYczJaUloyeHpMN2lHMUtxcy81VzZmdDRSbUxnK0JmNXBPOFdCN0RB?=
 =?utf-8?B?VUZaVlVTSk52WTMxb2VZN1hWQk9nd3Q0TTZNNWk4MmJ1eUxDZ054NUNwUk5B?=
 =?utf-8?B?VkVWNWpRaHBIekpNV1k4T2VUZmZpaU5hV1JmMnNYc3pPQkRTQXhjazI4cnkz?=
 =?utf-8?B?TmFVcGdEbUtOcHZBUWpNNnR1VUJIQStMYjFtV2pzUWdpZTVLVFZDQ0VvREow?=
 =?utf-8?B?aG00Q0wxR3ZRZERKaHpySGhYS3NPSTJzdk9WdGtaRDJsWTljUEV1RGw1aHRN?=
 =?utf-8?B?M1U4S0FYNFFNNHczd0ZGSUMvRVA4bkluOXUzY2RqUFhDZEhiVmltYnBOOGd4?=
 =?utf-8?B?bHpmWmFsYTNCdUwwbUg4bnVlWXFndDh3MFFQaUQ5VHltWG9ZNGhLNGQxRlZq?=
 =?utf-8?B?cHptU0lUSkgrN3RnU0RJL1NwQzE1RW8rSkY2YTRMVk1hYW9QSGhGSGFxNXUx?=
 =?utf-8?B?N3pjUEd2ZkpJcWc5eXZEMzA4bXdReU9oSWhXWkhLYmlURkR6bFVHY2tsakRL?=
 =?utf-8?B?eHRWM2FDS1hmaUhVWXdPMkNZRDRDSGxOSjBJcFBHM0s1Qzl3NGpMR1VyR2o3?=
 =?utf-8?B?UmV0RGZUeFZGbEZtT2o4OGxPZlBVRkp5WFBQMjJCUkR1aitCYndxOHo1ZUs0?=
 =?utf-8?B?aWZaRmg4ODhhdVNNT3REZmNDVEVINWJIeGFrRVhCMEYyelhqYlBReERMbWJy?=
 =?utf-8?B?NEFrSTMwcG0zNkdLeGdmYm5ZaXcxbkdvSFM4QzRaVlQwNlhQdWFVbmxDUDJB?=
 =?utf-8?B?OFBhck5lUGhiMG5mcDdqYitpMmJQTkQ5RnlkNFloYkxhSm5hbStwa3ZENXcy?=
 =?utf-8?B?am95RzMvc1ZFNHBPZjZKTEczT1N4S0lzRi9YY0V6b2d6NjJEOWxpYi8wNTEy?=
 =?utf-8?B?TTA2OUltNjA1Y2VzbGtKQWhzZTVnSW9mYnEyRC85YVV1YjZiMEV5QnRGdmVD?=
 =?utf-8?B?WmQyTEp5Y3J2QmFqMWZuWXFnNExXVThGTTZEMTl2SzZ3cmphbzB4bSsrY25O?=
 =?utf-8?B?YXVZUzloemEza2ozQmFYUHg1eURXTjl2N3dzMTJtQmRCTlpSUUZlQlFRam9J?=
 =?utf-8?B?aFRYWVJMN3lnMUdFaWN0elFSR1NTMW10Ri8ySUsybVZkaEtoRTZXTVMvQmhJ?=
 =?utf-8?B?cXpWMjI4enhJUExyMTdGYkdkVm9IbDY3SjhLZ0FFZlBLYld5VmJQcTZ0Sy8x?=
 =?utf-8?B?ZGdjTFh1dVFtOVFLNlRCdExDMW4vYXB4OXdDYndXcTNRUnBVaUlqakNpazNv?=
 =?utf-8?B?cEcrbnppaHh0eFdxbzViTnRvTXppSmNkTllxZ3ZnVEt4ZDdtTTBtZzM4ZUcw?=
 =?utf-8?B?aFlqcnVWRnJ0YXJRVGdDaHpkV21BbFFlU2Z0OGNkVUFTL29wTXFONjQxbHFJ?=
 =?utf-8?B?SXMyOG5UeVJ5cXJwb1VZdGFWOUFCTVVvTmcvWk1OMjdpcWM4eC93amlvczlU?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	p7pfXH8/Ee4cIZJEmkMc5Q/ZHcqJzM0AYla48C54V24GaUyi51FR2ATMNz9XKWD2bMHOM8HHh9OzG/YnTB6qOLjXP1FUuZ4Cn1QPj9EXFU+6njj22EpsLW0pOYRtAovVegIC2vUcRBNeGGi7E0PoROJNyZXfoV58CP0/8TuwLl7/KyMBdqgqCm4PHE8MArrXj3hPfz1RI3GH9YhN2bCcqLzq6zRfsB3LN/DFVcZY34EoOf/ZcG/uL6fk64ZrruofgaSTUNfZy1mPD3IymZxhfxRcahe8a0k1lV7U7aqsbJ6GxbcZbU/JQv9dr1OqtCzuQwYGCd34cNJ9+3tejd0gqBHOVQyftwTfZXpOC6onfFZktfU56SCIjAHNpTtxvCbQBNjylUKcerjuDpaS6CQQjcvLD78U2xVPc4VmLPLz46EYpqagvNq2o2nXyWCR6Ikg0ALigrS9MOQh+GV/AOOKs2SUF98v05/NkBmQl6GmYhXz90iRsEKWa6jmF+icc504MxbFgSseR1fmBUp3WkhiNFRtChI8WDiYo8Vq9WVn6EqJ4093xikzLlqf75syHSO6TKiE06QeUYmtHHzWj/7BVVKlKpnBcVQgY7jZyVeOlsk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f6edbc-ec80-4f8d-08d5-08dc294e5578
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 09:06:00.0706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+WYOMf+yTS5NmJ+Pun9dkm7YQPlpL4WJ6+d0Y6nWEpY5Cm6/CkDx/yq+L+8uurzFhL+NoxCSBqXAkJJe3hCtrqxylgkMqejtcbGf5x92L4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6324
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_06,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402090064
X-Proofpoint-GUID: kM9W69UrbnE_XotptdDp4SpZKP88CNDh
X-Proofpoint-ORIG-GUID: kM9W69UrbnE_XotptdDp4SpZKP88CNDh

On 09/02/2024 02:40, Baolu Lu wrote:
> On 2024/2/8 17:14, Yi Liu wrote:
>> Should set the SSADE (Second Stage Access/Dirty bit Enable) bit of the
>> pasid entry when attaching a device to a nested domain if its parent
>> has already enabled dirty tracking.
>>
>> Fixes: 111bf85c68f6 ("iommu/vt-d: Add helper to setup pasid nested translation")
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>> base commit: 547ab8fc4cb04a1a6b34377dd8fad34cd2c8a8e3
>> ---
>>   drivers/iommu/intel/pasid.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>> index 3239cefa4c33..9be24bb762cf 100644
>> --- a/drivers/iommu/intel/pasid.c
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -658,6 +658,8 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu,
>> struct device *dev,
>>       pasid_set_domain_id(pte, did);
>>       pasid_set_address_width(pte, s2_domain->agaw);
>>       pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
>> +    if (s2_domain->dirty_tracking)
>> +        pasid_set_ssade(pte);
>>       pasid_set_translation_type(pte, PASID_ENTRY_PGTT_NESTED);
>>       pasid_set_present(pte);
>>       spin_unlock(&iommu->lock);
> 
> The same fix should also be applied to the intel_pasid_setup_second()
> path. Specifically, if a second-stage domain with dirty tracking enabled
> attaches to a device, the corresponding entry in the pasid table should
> also have the SSADE bit set.
> 

I think that's already done, see below.


/*
 * Set up the scalable mode pasid entry for second only translation type.
 */
int intel_pasid_setup_second_level(struct intel_iommu *iommu,
				   struct dmar_domain *domain,
				   struct device *dev, u32 pasid)
{
(...)

	pasid_clear_entry(pte);
	pasid_set_domain_id(pte, did);
	pasid_set_slptr(pte, pgd_val);
	pasid_set_address_width(pte, agaw);
	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_SL_ONLY);
	pasid_set_fault_enable(pte);
	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
	if (domain->dirty_tracking)
		pasid_set_ssade(pte);
(...)
}


