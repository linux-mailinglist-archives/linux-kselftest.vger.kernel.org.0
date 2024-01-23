Return-Path: <linux-kselftest+bounces-3432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B16F839768
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 19:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F47F1C25639
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 18:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EACA8121F;
	Tue, 23 Jan 2024 18:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ej7CPKnL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CayHZsCe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB68180059;
	Tue, 23 Jan 2024 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033738; cv=fail; b=LmDtx8n0EbBmagoyAQGmSv+aKYoQBPQpxl0A+9xCT0RMFr+wkO1tvTH5hRb4tY4fbi0Z73Y3C+xswdvnjfYxd9/9htlH95y+UOBWSUUbj59AzMvxQDC2IVCEkztU8NfDg16WBNWIkYgUpenJGtr13BhoHSL5s5/kOxbAABkZr08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033738; c=relaxed/simple;
	bh=6KKpFLh0HKmKCwsiuVOa9HVnXW6EIWeK66hHWm//hfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pv27fSXDSPrmHz3UDU3glDfdRUKgQ7zg0LYUGjYMDrKIqJ2iuddqDmZ1mJ+KZLvw5zDi1AQ1NrJoASk+xRdH83A4AnIvT5v9JBD1c2yAl0sEjtsWgdqNcunPSl1uM6jJcGixKxuIy1F2Y4ljvjYgGq+b8qKfkzuUowJ42nWy2mY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ej7CPKnL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CayHZsCe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40NGRYQR022828;
	Tue, 23 Jan 2024 18:15:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=1To00TjnKcSo0X2wsyObyIpeEsmtdtAj3O4svE2cakE=;
 b=Ej7CPKnLE8xfaq229ZnMP4A4PFaLfcWqLXbyR0QGr+lvnHfaXjsfp9iXAUnEVe1gGgHS
 J83GgAGYx+1YdBXnsOVGpk2o7G2OPzPDqZpEyzxNLRMtdSelei2Asn8mNma0S6ERehzk
 lfd9dlOsKFrr+vYRa0GQC8hN2Z+MCWpR5uhGcSsqgLbC5Rf4VjWTU1Xpn3ynl9SwpeDV
 oMISqS1PvhsDLrOeAYgEbtBtRwSfg5hcrPYCNf5wz6dAjfpE4GFTparsVP+xdeWXMy3A
 P21QqxoSUTSlp6pZnpBZNOmIinRK/g6GNbJ5XdVFCE+3QgGLmX8fL33GEJY6MXP3wQxT bw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr79vy45g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 18:15:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40NHckuN040800;
	Tue, 23 Jan 2024 18:15:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs315q5q5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 18:15:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9RByzhBVvigi1vj5V9s+OiQ+JTDO1NHZvlDNEcvbQzMv3D4RkX7IZ2MpJBThg2CfmAtFz1N30JfsVqTAUx+VGv4L2QV3/QjNcy1Z5pmS1lkC3582HOp/YR3C9oY/8KskTZR4NeRTR3dKYxxcP19PeY8IOA1uxqocgGLI8x9SLEF5ArthAnOLO4DSbm7ceP1mkUm7Klu9tuZ4tQVauRslH+KPymi2jAnrYATPLEpO5Gg2mpSrTkB5cYF3fKZAsba3re3ChBMgLPFP3Z9b5zKFuu00o7M9AQG/k2BlMqdWr4KGQfUsvC1Jtl5PEgax/B6kRhTgrSN+UIU65iHheTuSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1To00TjnKcSo0X2wsyObyIpeEsmtdtAj3O4svE2cakE=;
 b=Z6S8fe8XgP7AYy4sC+D4Qg9un6H5HZZ5eZY9YKFX9p9XHBc71LB4XUW6YUL5G5hYVhqmxEZAuBCycx7/oLoGwpufSliY8IblSnWMVAgsF3vjRHRLHYQkrAABLFMmJcOl4np23BF0bqRC6Aa89QaVnRkccrab7Ujo7QxDb95rgOQX1GhIlEx9O9DptzMBUZURkm44q8ZrP2Ulyen22pOh0v+CeAaGwttdD2Tytn2rMrvTk48KqwnQfg7P8sYTVsgtVco8K6FwQiI4wMEgb2JOosgjfJ0gWD9fce2z31NkLocabAhaIPKHawpwj3P04r+9eu1obKpJkOWg2BpQ61P0PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1To00TjnKcSo0X2wsyObyIpeEsmtdtAj3O4svE2cakE=;
 b=CayHZsCeeYyyYYxLakh7C10IGHAxzao9w911Y06mN55E7ZEceOw8lXSKFMy3X5R8h8k6J17YVOJ/B1Q0xDlatYaGaZ2QA4LNm0f+5ENX12wuJEtcNOWFfQrqM8Q2i9IqAgMcpevYVyqlVKIN7BHCZiA1q0x3Nl0mSTw4xiD1b/c=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA1PR10MB6640.namprd10.prod.outlook.com (2603:10b6:806:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Tue, 23 Jan
 2024 18:15:00 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7228.022; Tue, 23 Jan 2024
 18:15:00 +0000
Date: Tue, 23 Jan 2024 13:14:57 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, usama.anjum@collabora.com,
        rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        pedro.falcato@gmail.com, dave.hansen@intel.com,
        linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [PATCH v7 2/4] mseal: add mseal syscall
Message-ID: <20240123181457.idckaydk7dt7q2qy@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	jeffxu@chromium.org, akpm@linux-foundation.org,
	keescook@chromium.org, jannh@google.com, sroettger@google.com,
	willy@infradead.org, gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org, usama.anjum@collabora.com,
	rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org,
	groeck@chromium.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	pedro.falcato@gmail.com, dave.hansen@intel.com,
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
References: <20240122152905.2220849-1-jeffxu@chromium.org>
 <20240122152905.2220849-3-jeffxu@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240122152905.2220849-3-jeffxu@chromium.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0446.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::7) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA1PR10MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: dcb95f61-6a1d-4577-05be-08dc1c3f3646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3jmaOHcZYKru8t4FBrXZX3VbM9jZQ6h4qvxn6JqqiT1c7TJ/XctKI7qFrVIrcfAb8mxtmtDBQX9lXnpn7B0yHLuudX6g1Tnt+4WMQub1Boop5djpWrp/zyK1j5gEIior1QH8u9HZb5YpXwIfyjliTOycwuN7lMaaO4EB3XIdYbrTsxA0zOonq93zC7R2vnEUVBXKp/+Mltyti8BOTGdFpN2XoE+9gEbYSVS2MYirZ3PMAwAhhjLubASNhR6LnjpkpA5WqrRWPPkDPFcDUdFrZA8DuSdZSTqkq6Bd7BFI7i3SphmkwdJ9vcP6lgMkGitony5mgeNiL53Z+CKTn2689+rstNzc8mpvQhOYTO+naSNhyrK+UJciy4WKC5mXbpQlZUUHyB2YnWW8GF8owSKjFGbWBmti/G3wGZXzR4KShx9D2uzr6quAAQ19F16PqwE6yZ5RVFZHbCiOD9Xzmjb2wCZZ1rd8jzXthi/GxsdpClU95gao8F+wudWv2TMxYgaYL43kxZ6nKfP9ytY0pxQA3RdSvxwFxg/w9lsv20tI3A5YTRtzRKfmW4S8R7X88qnp
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(366004)(396003)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(33716001)(8936002)(86362001)(6916009)(6512007)(41300700001)(8676002)(38100700002)(4326008)(316002)(66556008)(26005)(66946007)(6486002)(66574015)(5660300002)(7416002)(478600001)(66476007)(30864003)(83380400001)(2906002)(6666004)(9686003)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WG9iUEtDczBScjA3a2NieFE5MVUvQnlRa3pJaFJSVXhFUGNxQWJ5MlRnYm1i?=
 =?utf-8?B?aTlmajROUDY2RDNEV3E0VzZCNCtwUGRRcFRMQ2tRMm9hSHdlcEFYRFRsbmFt?=
 =?utf-8?B?SDkwSEd1NHJhSVdkWWVFKzk1RE1CK1gyWFp2TUZ5ZTFORjhsdlNpN0NUa0VR?=
 =?utf-8?B?Vk9ZdU1xa3FheE5zL01rMnhyVm43czJiK2taaW5wN1hvNnV5dVl1YkRZSkhX?=
 =?utf-8?B?WlV2a2hvNW9SaFBoM3NLTG5ZemU4U1BLOVlkdkxCa0ZSamJLSk5xWVltKzVH?=
 =?utf-8?B?WTF4cjFYVVBOblV5WUFlWFpZQW44QUdjblNQTGNQWkcxUjhCbmRqT0VDT2lo?=
 =?utf-8?B?OU5kcDMvQWxhNHJ2eC8vU3UwREpRV0E5YTBRSiszcWdrQWFrN0dlRW5wcmIx?=
 =?utf-8?B?NWNYLzZ5b3RScGRxKzZUVG5RUWhmN281Z0Z2VENjLzFQKyt5R2lSUkphUzQz?=
 =?utf-8?B?cHdJSjJoMmJVSVdVVlNLaGpiaVVPcUZ6QVRCRkJER1NNNWI2RTloZTdHQmVG?=
 =?utf-8?B?OTR2aUhzdmpQMW1KQ1FkVU9OSitORXpZQkdDWjhNZ1JoYXZ3aUQ0WFB5K2xJ?=
 =?utf-8?B?SGM5Z0ZEaysrRWFNTndkUitud0JKdE8xUVJFOFJxZENJdmt2elhUaXFZdWc0?=
 =?utf-8?B?UFpBdDF6anR1cUtuTmlhWTNGaTM4K2F0VjduckMyZHFnZmc3ZFI4ZEkxM0pQ?=
 =?utf-8?B?UXJkS3FoVzJKSmJaQkp3MUozS2RualJ2eURkWDlCWnRxQ0Y1N2NPSjlCcTdo?=
 =?utf-8?B?UitDZjdmUEhuOVJ4aXRNa3ZZK1RWODlKN1paNXR2blRsSEc5RXBueTFPVjFM?=
 =?utf-8?B?cmoxeGUvcHZTSzQrb1MzWXhOTFB4S0R6TGdLYldJTm1lUVJKVzRLcEVsaTNq?=
 =?utf-8?B?cXkxdDM0UlZId2dUc1g2R0NxZ2pBYXV0NWNUMHoyeS8vblE5M2kwZElyalZC?=
 =?utf-8?B?enY5M3VqeTUvQnNWMzZmS0xCZm41b2Y3UWlWZUJqenhlQXl3MC9PbXBLR2th?=
 =?utf-8?B?ay9nRnBZRjVYc3JTQ1AxU0dYUEVYTkQ3aGE0TXRDKzB4TlpzY2RPTmdSRWh3?=
 =?utf-8?B?YnNLczBnZUdoZWhCS0JvYjNpaC9xa1pkMWZkb3NPSm1VL2hUQzRyR21ZK2Fa?=
 =?utf-8?B?b242ejlCbDNxcXFyU0c1aGVrRitCZHNWaFE0SU05b2h4TmY1VnFiWlR3bDhn?=
 =?utf-8?B?RERmRDYxdUZKc2ppYVZBTFJQNjRlbEhtbVJsK2Rlem43NUFhZStTWmt5SnY3?=
 =?utf-8?B?THFWekJOWmNwbDUrMmNPRFFYZG0zRlIvelFNemFobTd5ZmRWUVpIdTNEU2I5?=
 =?utf-8?B?aXpwU0lYVU1HRW9RQ3RZZnFWKzdxK0U3QTBWbEp5d0hUYnNpbU93OUFxbFYy?=
 =?utf-8?B?YVpJNGQ4ZTZNTmEzL3RuRnI5OXA2ZUVKNE1KTVcrUDlwVHVKaVB3VkxvMGww?=
 =?utf-8?B?V1FUbTkraFVSSkF4QlY4ZEdCOGZxOGEwZGRLVmY4N2FwMFJIVEN4UHBsT1Bk?=
 =?utf-8?B?aXdKWFdwRnVaV2QydzNFd0RKdlZWUCtKVmZTR3hNZkN1SkJsRTVWT2tEUmNT?=
 =?utf-8?B?dnRMd01LTnJWbGg0RkQza0FKekFxM210OUVwMTVsalUra3ZTU2h6em5SaDRs?=
 =?utf-8?B?ejdFYmo3WHl0ZENFajk2K0dIZTRqcW5zdVhHM2xtQmNmSHVRMjF2YWNWZndq?=
 =?utf-8?B?djNlZFpHcVNoZmtYWklaRnFhQlZJRTVJcVZDUGt5emVYWkRiT1FSTWZwNWlL?=
 =?utf-8?B?VXRsU29LZmQxYmREdmIvYlpiRU92ZGpVbTJBK0JpeWtKa2N1Si9JbnJCaVNN?=
 =?utf-8?B?cWZOSWJjTGVGN012SExtS1puRjRyOXp3c04ra2I5NjhZb29Td3hoR0M1ZUhh?=
 =?utf-8?B?bnB6MUgycnRqNzVDTWEzbzhnOGRSS0xZL2pRY3lrSkJPT3pkWkNuYmZIRHcy?=
 =?utf-8?B?MU12QkRZT01uSUhOcnhWTmg4MzllcTJSN0Qzc1RZQnlyRkhCdldBd3hsK0ho?=
 =?utf-8?B?WnV2NEdlb0U1MzJPR2o4cW43c2lwN3RtTzVwWnZ5T2dhK3J2b1ZzVTZaMHVn?=
 =?utf-8?B?aFAyaTduZWQxY2YydHhzMGZrSWlZWUJXUjRHZjhzbDc5QTVYTURQazMyc2NG?=
 =?utf-8?Q?Thp98GmgJ5mPbJuE1bQYUmnc7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jrk88Gh6uFseggVdaQGrV/jY2DGUbgM90bZelK9QUOlPeA/slV/PgBdESAE9YFumKkjFORn4ZA5muVqMZp0bABnUQzDbGELTOUxpG9V5QK0E28hmMBviYE76X5QTV19jEp/UDi1+9jpSXWtu0tV4PFqCK4T9zpxXepwROYngIxqdeyHTuzeGZr4gTAJHNtlAUaOnG3Vh6cG6BKUAGDy7ezlnUqf6dexT9lns3uAwuKeEFE63qpB9Q8tBk9+xFgrVfjMyDSfyaO5JUEK4CpDQDvCOI/iqMBn4NWedmKm5CSBbgUUPo+ifZUIRsqwhMahR9BxOF/Wxn5jRQV43ii3ArTh4+RZC2an+Jh6rDLOvWZA5Va6pFcL4hFRMBSyjsXEczSmMHIgchkT83AZfY909k0AVIezJ/n8wV3hjhsvkgXfQr5kmVuPg13sTzI0yRxlDGGO0vzgdtu5PAujRFwb5W3rCCV/6c9bU96TMA+/muyYpmB7ZaqiicTiF75A/tEpV0S0gCf12lM6T5/eYVtWtFLNKrU7dS4AvJxM9870lnjGe+cMJWJ7v4QPoKGGIHAIJlHw4UcesL+fzQ/tcKTVG18gGUpUE6NhvxO4JgSX5Cu0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb95f61-6a1d-4577-05be-08dc1c3f3646
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 18:15:00.0180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /3OJOxo4yqi1w4qirXGZghw/sYgsOL5BLxguaxuzrhrmYusoyfomEqwLCldVu9dMCb7xm2ewYtqSNsQD4Awofw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_11,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=483 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230134
X-Proofpoint-GUID: gPRru8d5kuZVu4yE6wC3KwU4xbng0Jk5
X-Proofpoint-ORIG-GUID: gPRru8d5kuZVu4yE6wC3KwU4xbng0Jk5

* jeffxu@chromium.org <jeffxu@chromium.org> [240122 10:29]:
> From: Jeff Xu <jeffxu@chromium.org>
>=20
> The new mseal() is an syscall on 64 bit CPU, and with
> following signature:
>=20
> int mseal(void addr, size_t len, unsigned long flags)
> addr/len: memory range.
> flags: reserved.
>=20
> mseal() blocks following operations for the given memory range.
>=20
> 1> Unmapping, moving to another location, and shrinking the size,
>    via munmap() and mremap(), can leave an empty space, therefore can
>    be replaced with a VMA with a new set of attributes.
>=20
> 2> Moving or expanding a different VMA into the current location,
>    via mremap().
>=20
> 3> Modifying a VMA via mmap(MAP_FIXED).
>=20
> 4> Size expansion, via mremap(), does not appear to pose any specific
>    risks to sealed VMAs. It is included anyway because the use case is
>    unclear. In any case, users can rely on merging to expand a sealed VMA=
.
>=20
> 5> mprotect() and pkey_mprotect().
>=20
> 6> Some destructive madvice() behaviors (e.g. MADV_DONTNEED) for anonymou=
s
>    memory, when users don't have write permission to the memory. Those
>    behaviors can alter region contents by discarding pages, effectively a
>    memset(0) for anonymous memory.
>=20
> In addition: mmap() has two related changes.
>=20
> The PROT_SEAL bit in prot field of mmap(). When present, it marks
> the map sealed since creation.
>=20
> The MAP_SEALABLE bit in the flags field of mmap(). When present, it marks
> the map as sealable. A map created without MAP_SEALABLE will not support
> sealing, i.e. mseal() will fail.
>=20
> Applications that don't care about sealing will expect their behavior
> unchanged. For those that need sealing support, opt-in by adding
> MAP_SEALABLE in mmap().
>=20
> I would like to formally acknowledge the valuable contributions
> received during the RFC process, which were instrumental
> in shaping this patch:
>=20
> Jann Horn: raising awareness and providing valuable insights on the
> destructive madvise operations.
> Linus Torvalds: assisting in defining system call signature and scope.
> Pedro Falcato: suggesting sealing in the mmap().
> Theo de Raadt: sharing the experiences and insights gained from
> implementing mimmutable() in OpenBSD.
>=20
> Finally, the idea that inspired this patch comes from Stephen R=C3=B6ttge=
r=E2=80=99s
> work in Chrome V8 CFI.
>=20
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  include/linux/mm.h                     |  48 ++++
>  include/linux/syscalls.h               |   1 +
>  include/uapi/asm-generic/mman-common.h |   8 +
>  mm/Makefile                            |   4 +
>  mm/madvise.c                           |  12 +
>  mm/mmap.c                              |  27 ++
>  mm/mprotect.c                          |  10 +
>  mm/mremap.c                            |  31 +++
>  mm/mseal.c                             | 343 +++++++++++++++++++++++++
>  9 files changed, 484 insertions(+)
>  create mode 100644 mm/mseal.c
>=20
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f5a97dec5169..bdd9a53e9291 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h

None of this can live in mm/internal.h ?

> @@ -328,6 +328,14 @@ extern unsigned int kobjsize(const void *objp);
>  #define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
>  #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
> =20
> +#ifdef CONFIG_64BIT
> +/* VM is sealable, in vm_flags */
> +#define VM_SEALABLE	_BITUL(63)
> +
> +/* VM is sealed, in vm_flags */
> +#define VM_SEALED	_BITUL(62)
> +#endif
> +
>  #ifdef CONFIG_ARCH_HAS_PKEYS
>  # define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
>  # define VM_PKEY_BIT0	VM_HIGH_ARCH_0	/* A protection key is a 4-bit valu=
e */
> @@ -4182,4 +4190,44 @@ static inline bool pfn_is_unaccepted_memory(unsign=
ed long pfn)
>  	return range_contains_unaccepted_memory(paddr, paddr + PAGE_SIZE);
>  }
> =20
> +#ifdef CONFIG_64BIT
> +static inline int can_do_mseal(unsigned long flags)
> +{
> +	if (flags)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +bool can_modify_mm(struct mm_struct *mm, unsigned long start,
> +		unsigned long end);
> +bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start,
> +		unsigned long end, int behavior);
> +unsigned long get_mmap_seals(unsigned long prot,
> +		unsigned long flags);
> +#else
> +static inline int can_do_mseal(unsigned long flags)
> +{
> +	return -EPERM;
> +}
> +
> +static inline bool can_modify_mm(struct mm_struct *mm, unsigned long sta=
rt,
> +		unsigned long end)
> +{
> +	return true;
> +}
> +
> +static inline bool can_modify_mm_madv(struct mm_struct *mm, unsigned lon=
g start,
> +		unsigned long end, int behavior)
> +{
> +	return true;
> +}
> +
> +static inline unsigned long get_mmap_seals(unsigned long prot,
> +	unsigned long flags)
> +{
> +	return 0;
> +}
> +#endif
> +
>  #endif /* _LINUX_MM_H */

...

> diff --git a/mm/mmap.c b/mm/mmap.c
> index b78e83d351d2..32bc2179aed0 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1213,6 +1213,7 @@ unsigned long do_mmap(struct file *file, unsigned l=
ong addr,
>  {
>  	struct mm_struct *mm =3D current->mm;
>  	int pkey =3D 0;
> +	unsigned long vm_seals;
> =20
>  	*populate =3D 0;
> =20
> @@ -1233,6 +1234,8 @@ unsigned long do_mmap(struct file *file, unsigned l=
ong addr,
>  	if (flags & MAP_FIXED_NOREPLACE)
>  		flags |=3D MAP_FIXED;
> =20
> +	vm_seals =3D get_mmap_seals(prot, flags);
> +
>  	if (!(flags & MAP_FIXED))
>  		addr =3D round_hint_to_min(addr);
> =20
> @@ -1261,6 +1264,13 @@ unsigned long do_mmap(struct file *file, unsigned =
long addr,
>  			return -EEXIST;
>  	}
> =20
> +	/*
> +	 * Check if the address range is sealed for do_mmap().
> +	 * can_modify_mm assumes we have acquired the lock on MM.
> +	 */
> +	if (!can_modify_mm(mm, addr, addr + len))
> +		return -EPERM;
> +

This is called after get_unmapped_area(), so this area is either going
to be MAP_FIXED and return the "hint" addr or it's going to be empty.
You can probably avoid walking the VMAs in the non-FIXED case.  This
would remove the overhead of your check in the most common case.

>  	if (prot =3D=3D PROT_EXEC) {
>  		pkey =3D execute_only_pkey(mm);
>  		if (pkey < 0)
> @@ -1376,6 +1386,7 @@ unsigned long do_mmap(struct file *file, unsigned l=
ong addr,
>  			vm_flags |=3D VM_NORESERVE;
>  	}
> =20
> +	vm_flags |=3D vm_seals;
>  	addr =3D mmap_region(file, addr, len, vm_flags, pgoff, uf);
>  	if (!IS_ERR_VALUE(addr) &&
>  	    ((vm_flags & VM_LOCKED) ||
> @@ -2679,6 +2690,14 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct=
 mm_struct *mm,
>  	if (end =3D=3D start)
>  		return -EINVAL;
> =20
> +	/*
> +	 * Check if memory is sealed before arch_unmap.
> +	 * Prevent unmapping a sealed VMA.
> +	 * can_modify_mm assumes we have acquired the lock on MM.
> +	 */
> +	if (!can_modify_mm(mm, start, end))
> +		return -EPERM;
> +

This function is currently called from mmap_region(), so we are going to
run this check twice as you have it; once in do_mmap() then again in
mma_region() -> do_vmi_munmap().  This effectively doubles your impact
to MAP_FIXED calls.

>  	 /* arch_unmap() might do unmaps itself.  */
>  	arch_unmap(mm, start, end);
> =20
> @@ -3102,6 +3121,14 @@ int do_vma_munmap(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
>  {
>  	struct mm_struct *mm =3D vma->vm_mm;
> =20
> +	/*
> +	 * Check if memory is sealed before arch_unmap.
> +	 * Prevent unmapping a sealed VMA.
> +	 * can_modify_mm assumes we have acquired the lock on MM.
> +	 */
> +	if (!can_modify_mm(mm, start, end))
> +		return -EPERM;
> +

I am sure you've looked at the callers, from what I found there are two:

The brk call uses this function, so it may check more than one VMA in
that path.  Will the brk VMAs potentially be msealed?  I guess someone
could do that?

The other place this is use is in ipc/shm.c whhere the start/end is just
the vma start/end, so we only really need to check that one vma.

Is there a way to avoid walking the tree for the single known VMA?  Does
it make sense to deny mseal writing to brk VMAs?


>  	arch_unmap(mm, start, end);
>  	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
>  }

...


Ah, I see them now.  Yes, this is what I expected to see.  Does this not
have any impact on mmap/munmap benchmarks?

> +bool can_modify_mm(struct mm_struct *mm, unsigned long start, unsigned l=
ong end)
> +{
> +	struct vm_area_struct *vma;
> +
> +	VMA_ITERATOR(vmi, mm, start);
> +
> +	/* going through each vma to check. */
> +	for_each_vma_range(vmi, vma, end) {
> +		if (!can_modify_vma(vma))
> +			return false;
> +	}
> +
> +	/* Allow by default. */
> +	return true;
> +}
> +
> +/*
> + * Check if the vmas of a memory range are allowed to be modified by mad=
vise.
> + * the memory ranger can have a gap (unallocated memory).
> + * return true, if it is allowed.
> + */
> +bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start, unsig=
ned long end,
> +		int behavior)
> +{
> +	struct vm_area_struct *vma;
> +
> +	VMA_ITERATOR(vmi, mm, start);
> +
> +	if (!is_madv_discard(behavior))
> +		return true;
> +
> +	/* going through each vma to check. */
> +	for_each_vma_range(vmi, vma, end)
> +		if (is_ro_anon(vma) && !can_modify_vma(vma))
> +			return false;
> +
> +	/* Allow by default. */
> +	return true;
> +}
> +

...

> +static int check_mm_seal(unsigned long start, unsigned long end)
> +{
> +	struct vm_area_struct *vma;
> +	unsigned long nstart =3D start;
> +
> +	VMA_ITERATOR(vmi, current->mm, start);
> +
> +	/* going through each vma to check. */
> +	for_each_vma_range(vmi, vma, end) {
> +		if (vma->vm_start > nstart)
> +			/* unallocated memory found. */
> +			return -ENOMEM;

Ah, another potential user for a contiguous iterator of VMAs.

> +
> +		if (!can_add_vma_seal(vma))
> +			return -EACCES;
> +
> +		if (vma->vm_end >=3D end)
> +			return 0;
> +
> +		nstart =3D vma->vm_end;
> +	}
> +
> +	return -ENOMEM;
> +}
> +
> +/*
> + * Apply sealing.
> + */
> +static int apply_mm_seal(unsigned long start, unsigned long end)
> +{
> +	unsigned long nstart;
> +	struct vm_area_struct *vma, *prev;
> +
> +	VMA_ITERATOR(vmi, current->mm, start);
> +
> +	vma =3D vma_iter_load(&vmi);
> +	/*
> +	 * Note: check_mm_seal should already checked ENOMEM case.
> +	 * so vma should not be null, same for the other ENOMEM cases.

The start to end is contiguous, right?

> +	 */
> +	prev =3D vma_prev(&vmi);
> +	if (start > vma->vm_start)
> +		prev =3D vma;
> +
> +	nstart =3D start;
> +	for_each_vma_range(vmi, vma, end) {
> +		int error;
> +		unsigned long tmp;
> +		vm_flags_t newflags;
> +
> +		newflags =3D vma->vm_flags | VM_SEALED;
> +		tmp =3D vma->vm_end;
> +		if (tmp > end)
> +			tmp =3D end;
> +		error =3D mseal_fixup(&vmi, vma, &prev, nstart, tmp, newflags);
> +		if (error)
> +			return error;

> +		tmp =3D vma_iter_end(&vmi);
> +		nstart =3D tmp;

You set tmp before using it unconditionally to vma->vm_end above, so you
can set nstart =3D vma_iter_end(&vmi) here.  But, also we know the
VMAs are contiguous from your check_mm_seal() call, so we know nstart =3D=
=3D
vma->vm_start on the next loop.

...

