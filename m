Return-Path: <linux-kselftest+bounces-3485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2664983B2D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 21:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94D8282C42
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 20:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94876132C38;
	Wed, 24 Jan 2024 20:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c+FhT2dA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mRyYVeaa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88717C091;
	Wed, 24 Jan 2024 20:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706126821; cv=fail; b=Q4ojFL0n0LlT6c+glSqjYtSGlR6tcbN5d5wCUdv0fTFn01N1TBDIiMOFCbjbAhe9zoVwgxuxzPr+69aCN9kypJ6z2DNr5f3pBoCVu03Ocz7gzv7OAwJsvRzEj9UxKCp1gOS/DK3pH6LzHz4qLY4TW4IRPhO4ryw+qSl27/9vi4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706126821; c=relaxed/simple;
	bh=CWhrh0c+S7YHI/6mNmz93BUvhImJONNr+8CqR92HEZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ELJzyLWgGr6EtRhy2bTJN1q+VdCRbgTaCq0Zduxk8EhxOpm2nzmONLFoHEdqfBFoJoWOTI4RNb2zaT7IYkzomGGPdOdmXiK1gJnlCGauHjKGz8cPdIiD0DSbPyM6r8z956MgvsCfiFQzEgdmP+mUllfIsdPV9yxs9FbqdNrwmYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c+FhT2dA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mRyYVeaa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OHE5is029769;
	Wed, 24 Jan 2024 20:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=2XLtlceIjOZVJNVZiXcgl4V3BRtGhbu6gzEPbOYvgDk=;
 b=c+FhT2dAz3n27bLxEiJcs3nBzkvFfkCUexPD79qpzAldK9BuXHog/8069I3RRXmtcVdw
 6s7mdZendvt4FHuXfU/J89M+VAY6O94htYFbVcgDUtg0pdflZZure6MbKr4T98Azw0+c
 t5JnQ0ygYzmL4ql7M6DSQl6/iF0ubzdy5i0ux+zppzl4P4nBxy0aqlqL7w8iys3EEz43
 XEjb7QSBXEcW0d7nVj3QSAMzyHKN2vGd0YdQx2Lz5L1UM/Rz2auW/7575sUfZoobY1P+
 wcjl9QzShlyyi2os5N6E93/ggKf5HOey26zwa9QpdFj5dHf5MaT3MLx0z9fY1uaPIm0f xg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cy4fhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 20:06:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OIhdl4026037;
	Wed, 24 Jan 2024 20:06:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs317r9g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 20:06:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZP6tpPjO2/a4JW49j5o1fe6VfUBx03CfZoBGNs3hIlVNGhy8Cv1DlgpweB7pdNtaAs7i+ZIQBzRBStPbuoRthPBx6rPCIEk7lIT4MHLmhXx1nhx5r1cutx7yDI7Zae6Bh2h6VkObb67VqM4mFjtI0azFgTBStf0VWu8EvatHyVYT2X2UeMI5/sd5nGQwNOuk9tvP6uB5icFL3sMIyElOIMPl3F/OYmvKxbxQP9aq3Pts3hrr5dI2DGmJ3Q+Xho7shzUVj4wypxSS4zK+GHPZn5ZUQlLy8szBNcfTBA3XTZ1vE0BLXzC8Mh3UCXaty0Z2mkuSfgXjLBMDRl0Eg6vPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XLtlceIjOZVJNVZiXcgl4V3BRtGhbu6gzEPbOYvgDk=;
 b=KwU27AmZYoEyjz3cLYM35nuYIkVA37jP9GQ+mhs9V6PIAcRYZAmVZXQwrWEyQMMpPUSacIz766Sd31BZ55Hol4ukPitPffsEu3lpgLP3k0dHRAdLAI1yj3B+opWPpHL8U2/g8NkryR5UEpxHQSshJUYPfxDBrBCw+z2CANq3Gvb/PzkJJmrcGqlxBxAthiJd3pfxznKsneG/7G6auybkZC/OViD5uLLRgrJtXsvwhSscwphjSy/ioyHEfe341uCNk2lJsoet32QT3TEDevwqcc1jhVKHAQpDlQWo4QQnNMT7AhFD4d0Vwe3EUZ5AhslvPX5dpdN+S6WcFhu6NBfsPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XLtlceIjOZVJNVZiXcgl4V3BRtGhbu6gzEPbOYvgDk=;
 b=mRyYVeaaMNtgg3fS9Z2m2LY+o0FXciig4yO4FHwBdhlf8pwTJK60TFyxen9axrm5vDw9AJkIWd0KKv/0vL3E8pW+7fOB2IRIMWhSee2QBYm2a7b7I/kywrMklcNlV666xZko96jqUY6iD8/MYOsjYGDIT/xYMpDWzUtY9PoyGf0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB5700.namprd10.prod.outlook.com (2603:10b6:510:125::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Wed, 24 Jan
 2024 20:06:31 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 20:06:31 +0000
Date: Wed, 24 Jan 2024 15:06:28 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, usama.anjum@collabora.com,
        rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        pedro.falcato@gmail.com, dave.hansen@intel.com,
        linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [PATCH v7 2/4] mseal: add mseal syscall
Message-ID: <20240124200628.ti327diy7arb7byb@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org,
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
 <20240123181457.idckaydk7dt7q2qy@revolver>
 <CABi2SkX=wKnHmooxXzBnJxxmtfSjvfgYabN1Wh1LxFYjtFoFaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABi2SkX=wKnHmooxXzBnJxxmtfSjvfgYabN1Wh1LxFYjtFoFaQ@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::29) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB5700:EE_
X-MS-Office365-Filtering-Correlation-Id: b0dae887-a33f-40eb-ebfe-08dc1d17f4e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Irmkblhe/4nx7QGvvZwHRS9hPs3eGsFVJ72+1WpjoF3RhpYRIHJ8pOZRtJEQJLUE4H/A0mbvw+2VSxhesxE6Aq8kSMkgMA0FrArwOjVZqhqHnSLzUl/iYiey3uRCKvc62e+WH0rOECw2bsVdcZ8LU2ugpsYsPJYUM+zNc8B8eII+tUaox23Z8Hda//FEpu248u1XtsR+f4XEVLByM5NTL594mlLjygulTckpJFzuGGuX3As74MU8whp2dAQ+OeAowImUOOJJFwx9FZ2GwTC9aGUBdGB6J1KSi2lONho3yUoEP9sTTElc4nQ8dT9Y9fyTv2j34Q6416evOKpx7CjZPaJRDzVu8VvuTMaYsuRxhuzW550qhQJuoMwjpYxD7WGWJyW2w5jHW+eeP0nvFTjjvBfkdwVR8ZD98exco+8KtMwASckKK2wadKESdHN+HGx4yadUbPaderSngIDzsI7A4Y45deHynPOK9Fu5ewMJ9cyejTfb1UXzGyxjJl485RV1Gpkef6qeqUyKpBnjN+FsCMAsHCgR71uSBXJ7iAaH6GXVdQQ95a3IZISOymfYcTsMKhFyOrjgkW68b0zLlG8kbjs2+FGVqlgjbXKhqahucT8NSQZAIcpDfioqLpwi6iXDC5pqAXka5wkIxZ+39QjQcw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(346002)(39860400002)(396003)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(1076003)(6506007)(9686003)(6512007)(6666004)(966005)(53546011)(83380400001)(66556008)(26005)(8936002)(38100700002)(66574015)(86362001)(2906002)(41300700001)(66476007)(33716001)(6486002)(4326008)(66946007)(8676002)(7416002)(478600001)(316002)(5660300002)(30864003)(6916009)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dUlWM2l6MUV5L1B6d3kwUUlSWDRkVjYvREVXZ2pmMXlFcnluZER0aUZUdHo3?=
 =?utf-8?B?bThFQWtodldMWWxNSk5RQ2xvY3ZsYXgycXZTcU12R3RPbitpNkZ3dTJNdWJI?=
 =?utf-8?B?ZUhJQm1wak9qMWw5a1o1dEgvZXJFcENuRDVQSXovQWhoNXlZWDR4SnB3REIr?=
 =?utf-8?B?L244WngwNHd4OXQrd29yK0hMNFpPbDEwV0pqWTBHU1BIR2pCNVhVU1VZNHdC?=
 =?utf-8?B?MTlQZTlsYklsSFczQ2YzT09YcCtmMWt3blY2SjIyeHV0aE5WMHhoZVRuWnRF?=
 =?utf-8?B?WEFhdEJxSWE2cThCb0FrS1pYSS9Cc0Z0WXRLWk5ST0NUejJpRlFOOE5OampC?=
 =?utf-8?B?UU5wWnZLUy9JWExaS2JkUDk1UWNDZk5MbkRMLzRraGcvZG9PWnRDT0FlckY3?=
 =?utf-8?B?cDFNTGNlcVJEMllBSWJxaXUwY0VST2grMjBzclgzTnM5WFpRMjRUS0R5RjQ3?=
 =?utf-8?B?b3lIU012WTNqQlQ0eHRoVjByMDVzMHdxNittTUczK25pby9taTQrYWNGMlQ3?=
 =?utf-8?B?WkRDS1hoS3Vwd1Y0ZXlXM1hNSG1wWEwyanBpVTBselJuYnFFcWVFRVNtaGEv?=
 =?utf-8?B?YUYzOWZKR3N6MUJrZzl5ZGtSbStVd0pCVGM5bFA4Rm14ZllnaXBDU0lveFZo?=
 =?utf-8?B?a0FkbHRZdzhGRkN1MmhQZ0IzM2daNEt0K0N5UTUwRWs5NkxsbjFqWDhEQmpL?=
 =?utf-8?B?bm5DTCtnalY3ZVR6c0pGdHZkVCtCZ0taWk5KUlJBdFJnbGVQS3A4OXF2QjZK?=
 =?utf-8?B?RXhBdnlPQUZDdCtJREV0dVZZak92bk1YRytaVG9ZQjkvSkVUNFJ0eTlaSnM3?=
 =?utf-8?B?cytLYjFoclUvOXpNREp0VkdnVnY3V2RBcjY3LzVkOUtia0xIalFaRFBNK21v?=
 =?utf-8?B?S2ZoY2xDSjdEODhnSS8weGgxN0oxeU1veExXWkZEYzNETTdYREtYblRmNUhk?=
 =?utf-8?B?S3J1ZnN6Q0JnQk1WRDVvUGVyV2xNN0pNZ28yYkM2ZDlCU05mVFVQSE9vK1Fh?=
 =?utf-8?B?MW1ZclRESnR5R2F0OEU1OGc2RjVrRnJrR3U0dFlSWXZiYTdGOTFoVjAvY3ZM?=
 =?utf-8?B?VlNzaURHSC9PQnA4ckhqWlowb2oyMG05U2JncHdHV2RLWS9OUUZKdW1RUElB?=
 =?utf-8?B?aE1vSDNmamJBNHptV0x0b0FxcTE4Z1NiM2xxVVN4c3lmdVZFdXk2MEtQR2dN?=
 =?utf-8?B?T3lGTC9EZThSYUlrT2NwenpUd0kwcjA0L0Z5ckdEYm5tdFVkcmlidkRtd2VJ?=
 =?utf-8?B?OWcrVEcydWVOUmxRRGV4ZWViTWRkU0pIb1JwbDV3bitITGdLakUxaFBPelFG?=
 =?utf-8?B?UWxZT053WnN2eUh4RjdROHRpUEZ5SWdjM3N6YVR1N1hOQ1JTdDVoQlJWYjcv?=
 =?utf-8?B?ejRCTi9LOVdzUXNuMWl1bmwvSElGUnZZazRPUGNPYkRoc1NpUEVjVGQvU3JP?=
 =?utf-8?B?V1MzemtIWGZVeE8zTjlyMExwOHk3SzNCMStvUDFXaGI0aXJGUUZEbzUyRlVr?=
 =?utf-8?B?TFlQV1J2b010OVFad0dOQ3VMVjNRZHdxcGFCZVlEajBiZmh5YWZ5WEU1Tnk0?=
 =?utf-8?B?cVRUOVVuYlVwa1lVQkgvQjFoOG9EbVVkNlRIRzZKQklmR1o1dnVCenJydDhV?=
 =?utf-8?B?eHdxWGlEUFZONytmUDE5TFVqL1M5Z1piWVprZzh6MUtjZkpWWnJCcTNJUlZD?=
 =?utf-8?B?L0FhQ1FuZUxoMXEzMzFPL0JmcjcxNkFxVkVjWFNqRU1ZaEduT21BeTFOSFIz?=
 =?utf-8?B?ZFZtUWVoWDVxLzlSMTV4NWN2ZFhQSFJLMytxSWlZUnZOKzAzbUtmOEZmbVBt?=
 =?utf-8?B?ZmNIT0RobXZuMlNRSjAwN1h6aWRkU0hhcko5c3ZtcUpyUWp0WjNZVDE5MXFJ?=
 =?utf-8?B?NCtrbUVuQXM1TDR0aWZjUUVHSGhGMndKN1JkM3RyL0s5VjU5NW5GZEJncnh4?=
 =?utf-8?B?b21SZDM4WjkzblhjejFLVHQ1MVNmelo3QVNxSnRodUFSZjJVa3FYMUZjSUpv?=
 =?utf-8?B?cUxjQ3UzTWovSlJteWhCWk9RL1JITmdsKy8xQXRGZEROc3JJbzh3aGsyenRz?=
 =?utf-8?B?bThQaW9ueHZRSEhaSTFPZmVPWkZRYmdBcmxERDVqcVZkam9hVUNvYVJKOVl5?=
 =?utf-8?Q?0PU41a6IATQdunQlHfYGAf5DV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6l8tXrmmnpwc0hbHdbMJ0mJomXoNiF6axMBrTv4JZ5Vqy51aRBK2q/Ib4jT5/R7Oxhgmig+GTjJm2IOAoyOSWZXXKCtYobhVj0v0fhaCWrMTmZ55XkdTQmUZ4zqxtngOGfUa46/8q/QICRc2JKR3cQbrp24XW1j7ooA52oy8MEIdUk7gVxUc4WfC8HXDwyIoFEkxBXJ6YK0okiufy+NGqrPxt1eVeGXdNKcXKnskjDl67bXPzP7MIMJbd/Ww+FTeEP3rvFe6JzqRrLcL8lQKEaNeuP6R4fe8hgW9+V88S9BjFFA6mJIRGqlW7c/ii4knJq8SOKayd8zeLcWajNW4IZdtEpsiuDeX+pMmxLmqC5tG5ssQEZ4XdlRAdKqqWx7qmCdnnsEFnWR8e048t0exhLH280mGf1G1EE16nvpD4u8H/S1BQOxx+8Ca8nyHjdWJfhKrKkCA5HIgrsFeF20p7l0Uf2cSymGW2Kdnvvn40TMJzwokMKIFch/itRlCwqqpIesBCtROPmvicSsHroCwbXrzreMPY6gMosu8I08eLdnUnIMB8uF+ikTZbXu6w/5A/73qFM2ZRPfsLuC0Qo0PsAgogIOwGrYZvFuD2K6Hamc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0dae887-a33f-40eb-ebfe-08dc1d17f4e5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 20:06:31.1585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kxpCoEZNmvmz5VGEMW2jvPzildl6YyRcxtkkPAmCY+8+4co9nE3fCplcKUGj99h/60FilLz1PNxajiza3iKJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_08,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240145
X-Proofpoint-ORIG-GUID: Qs5pS5vBQfCdr43IwsRGXimY75uTLYlP
X-Proofpoint-GUID: Qs5pS5vBQfCdr43IwsRGXimY75uTLYlP

* Jeff Xu <jeffxu@chromium.org> [240124 12:50]:
> On Tue, Jan 23, 2024 at 10:15=E2=80=AFAM Liam R. Howlett
> <Liam.Howlett@oracle.com> wrote:
> >
> > * jeffxu@chromium.org <jeffxu@chromium.org> [240122 10:29]:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > The new mseal() is an syscall on 64 bit CPU, and with
> > > following signature:
> > >
> > > int mseal(void addr, size_t len, unsigned long flags)
> > > addr/len: memory range.
> > > flags: reserved.
> > >
> > > mseal() blocks following operations for the given memory range.
> > >
> > > 1> Unmapping, moving to another location, and shrinking the size,
> > >    via munmap() and mremap(), can leave an empty space, therefore can
> > >    be replaced with a VMA with a new set of attributes.
> > >
> > > 2> Moving or expanding a different VMA into the current location,
> > >    via mremap().
> > >
> > > 3> Modifying a VMA via mmap(MAP_FIXED).
> > >
> > > 4> Size expansion, via mremap(), does not appear to pose any specific
> > >    risks to sealed VMAs. It is included anyway because the use case i=
s
> > >    unclear. In any case, users can rely on merging to expand a sealed=
 VMA.
> > >
> > > 5> mprotect() and pkey_mprotect().
> > >
> > > 6> Some destructive madvice() behaviors (e.g. MADV_DONTNEED) for anon=
ymous
> > >    memory, when users don't have write permission to the memory. Thos=
e
> > >    behaviors can alter region contents by discarding pages, effective=
ly a
> > >    memset(0) for anonymous memory.
> > >
> > > In addition: mmap() has two related changes.
> > >
> > > The PROT_SEAL bit in prot field of mmap(). When present, it marks
> > > the map sealed since creation.
> > >
> > > The MAP_SEALABLE bit in the flags field of mmap(). When present, it m=
arks
> > > the map as sealable. A map created without MAP_SEALABLE will not supp=
ort
> > > sealing, i.e. mseal() will fail.
> > >
> > > Applications that don't care about sealing will expect their behavior
> > > unchanged. For those that need sealing support, opt-in by adding
> > > MAP_SEALABLE in mmap().
> > >
> > > I would like to formally acknowledge the valuable contributions
> > > received during the RFC process, which were instrumental
> > > in shaping this patch:
> > >
> > > Jann Horn: raising awareness and providing valuable insights on the
> > > destructive madvise operations.
> > > Linus Torvalds: assisting in defining system call signature and scope=
.
> > > Pedro Falcato: suggesting sealing in the mmap().
> > > Theo de Raadt: sharing the experiences and insights gained from
> > > implementing mimmutable() in OpenBSD.
> > >
> > > Finally, the idea that inspired this patch comes from Stephen R=C3=B6=
ttger=E2=80=99s
> > > work in Chrome V8 CFI.
> > >
> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > ---
> > >  include/linux/mm.h                     |  48 ++++
> > >  include/linux/syscalls.h               |   1 +
> > >  include/uapi/asm-generic/mman-common.h |   8 +
> > >  mm/Makefile                            |   4 +
> > >  mm/madvise.c                           |  12 +
> > >  mm/mmap.c                              |  27 ++
> > >  mm/mprotect.c                          |  10 +
> > >  mm/mremap.c                            |  31 +++
> > >  mm/mseal.c                             | 343 +++++++++++++++++++++++=
++
> > >  9 files changed, 484 insertions(+)
> > >  create mode 100644 mm/mseal.c
> > >

...

> >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index b78e83d351d2..32bc2179aed0 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -1213,6 +1213,7 @@ unsigned long do_mmap(struct file *file, unsign=
ed long addr,
> > >  {
> > >       struct mm_struct *mm =3D current->mm;
> > >       int pkey =3D 0;
> > > +     unsigned long vm_seals;
> > >
> > >       *populate =3D 0;
> > >
> > > @@ -1233,6 +1234,8 @@ unsigned long do_mmap(struct file *file, unsign=
ed long addr,
> > >       if (flags & MAP_FIXED_NOREPLACE)
> > >               flags |=3D MAP_FIXED;
> > >
> > > +     vm_seals =3D get_mmap_seals(prot, flags);
> > > +
> > >       if (!(flags & MAP_FIXED))
> > >               addr =3D round_hint_to_min(addr);
> > >
> > > @@ -1261,6 +1264,13 @@ unsigned long do_mmap(struct file *file, unsig=
ned long addr,
> > >                       return -EEXIST;
> > >       }
> > >
> > > +     /*
> > > +      * Check if the address range is sealed for do_mmap().
> > > +      * can_modify_mm assumes we have acquired the lock on MM.
> > > +      */
> > > +     if (!can_modify_mm(mm, addr, addr + len))
> > > +             return -EPERM;
> > > +
> >
> > This is called after get_unmapped_area(), so this area is either going
> > to be MAP_FIXED and return the "hint" addr or it's going to be empty.
> > You can probably avoid walking the VMAs in the non-FIXED case.  This
> > would remove the overhead of your check in the most common case.
> >
>=20
> Thanks for flagging this!
>=20
> I wasn't entirely sure about get_unmapped_area() after reading the
> code,  It calls a few variants of  arch_get_unmapped_area_xxx()
> functions.
>=20
> e.g. it seems like the generic_get_unmapped_area_topdown  is returning
> a non-null address even when MAP_FIXED is set to false
>=20
>  ------------------------------------------------------------------------=
----
> generic_get_unmapped_area_topdown (
> ...
> if (flags & MAP_FIXED)  <-- MAP_FIXED case.
> return addr;
>=20
> /* requesting a specific address */
> if (addr) {  <--  note not MAP_FIXED
> addr =3D PAGE_ALIGN(addr);
> vma =3D find_vma_prev(mm, addr, &prev);
> if (mmap_end - len >=3D addr && addr >=3D mmap_min_addr &&
> (!vma || addr + len <=3D vm_start_gap(vma)) &&
> (!prev || addr >=3D vm_end_gap(prev)))
> return addr;                         <--- note return not null addr here.
> }

Sorry, I was not clear.  Either MAP_FIXED will just return the addr, or
the addr that is returned has no VMA (the memory area is empty).  This
function finds a gap to place your data and the gap is (at least) as big
as you want (usually oversized, but that doesn't matter here).  The
mmap_lock is held, so we know it's going to remain empty.

So there are two scenarios:
1. MAP_FIXED which may or may not have a VMA over the range
2. An address which has no VMA over the range

Anyways, this is probably not needed, because of what I say later.

>=20
> -------------------------------------------------------------------------=
---
> I thought also about adding a check for addr !=3D null  instead, i.e.
> if (addr && !can_modify_mm(mm, addr, addr + len))
>     return -EPERM;
> }
>=20
> But using MAP_FIXED to allocate memory at address 0 is legit, e.g.
> allocating a PROT_NONE | PROT_SEAL at address 0.
>=20
> Another factor to consider is: what will be the cost of passing an
> empty address into can_modify_mm() ? the search will be 0 to len.

Almost always zero VMAs to check, it's not worth optimising.  The maple
tree will walk to the first range and it'll be 0 to some very large
number, most likely.

>=20
> > >       if (prot =3D=3D PROT_EXEC) {
> > >               pkey =3D execute_only_pkey(mm);
> > >               if (pkey < 0)
> > > @@ -1376,6 +1386,7 @@ unsigned long do_mmap(struct file *file, unsign=
ed long addr,
> > >                       vm_flags |=3D VM_NORESERVE;
> > >       }
> > >
> > > +     vm_flags |=3D vm_seals;
> > >       addr =3D mmap_region(file, addr, len, vm_flags, pgoff, uf);
> > >       if (!IS_ERR_VALUE(addr) &&
> > >           ((vm_flags & VM_LOCKED) ||
> > > @@ -2679,6 +2690,14 @@ int do_vmi_munmap(struct vma_iterator *vmi, st=
ruct mm_struct *mm,
> > >       if (end =3D=3D start)
> > >               return -EINVAL;
> > >
> > > +     /*
> > > +      * Check if memory is sealed before arch_unmap.
> > > +      * Prevent unmapping a sealed VMA.
> > > +      * can_modify_mm assumes we have acquired the lock on MM.
> > > +      */
> > > +     if (!can_modify_mm(mm, start, end))
> > > +             return -EPERM;
> > > +
> >
> > This function is currently called from mmap_region(), so we are going t=
o
> > run this check twice as you have it; once in do_mmap() then again in
> > mma_region() -> do_vmi_munmap().  This effectively doubles your impact
> > to MAP_FIXED calls.
> >
> Yes. To address this would require a new flag in the do_vmi_munmap(),
> after passing the first check in mmap(), we could set the flag as false,
> so do_vmi_munmap() would not check it again.
>=20
> However, this approach was attempted in v1 and V2 of the patch [1] [2],
> and was strongly opposed by Linus. It was considered as too random and
> decreased the readability.

Oh yes, I recall that now.  He was not pleased.

>=20
> Below is my  text in V2: [3]
>=20
> "When handing the mmap/munmap/mremap/mmap, once the code passed
> can_modify_mm(), it means the memory area is not sealed, if the code
> continues to call the other utility functions, we don't need to check
> the seal again. This is the case for mremap(), the seal of src address
> and dest address (when applicable) are checked first, later when the
> code calls  do_vmi_munmap(), it no longer needs to check the seal
> again."
>=20
> Considering this is the MAP_FIXED case, and maybe that is not used
> that often in practice, I think this is acceptable performance-wise,
> unless you know another solution to help this.

Okay, sure, I haven't been yelled at on the ML for a few weeks.  Here
goes:

do_mmap() will call get_unmapped_area(), which will return an empty area
(no need to check mseal, I hope - or we have larger issues here) or a
MAP_FIXED address.

do_mmap() will pass the address along to mmap_region()

mmap_region() will then call do_vmi_munmap() - which will either remove
the VMA(s) in the way, or do nothing... or error.

mmap_region() will return -ENOMEM in the case of an error returned from
do_vmi_munmap() today.  Change that to return the error code, and let
do_vmi_munmap() do the mseal check.  If mseal check fails then the error
is propagated the same way -ENOMEM is propagated today.

This relies on the fact that we only really need to check the mseal
status of existing VMAs and we can only really map over existing VMAs by
first munmapping them.

It does move your error return to much later in the call stack, but it
removes duplicate work and less code.  Considering this should be a rare
event, I don't think that's of concern.

>=20
> [1] https://lore.kernel.org/lkml/20231016143828.647848-6-jeffxu@chromium.=
org/
> [2] https://lore.kernel.org/lkml/20231017090815.1067790-6-jeffxu@chromium=
.org/
> [3] https://lore.kernel.org/lkml/CALmYWFux2m=3D9189Gs0o8-xhPNW4dnFvtqj7pt=
cT5QvzxVgfvYQ@mail.gmail.com/
>=20
>=20
> > >        /* arch_unmap() might do unmaps itself.  */
> > >       arch_unmap(mm, start, end);
> > >
> > > @@ -3102,6 +3121,14 @@ int do_vma_munmap(struct vma_iterator *vmi, st=
ruct vm_area_struct *vma,
> > >  {
> > >       struct mm_struct *mm =3D vma->vm_mm;
> > >
> > > +     /*
> > > +      * Check if memory is sealed before arch_unmap.
> > > +      * Prevent unmapping a sealed VMA.
> > > +      * can_modify_mm assumes we have acquired the lock on MM.
> > > +      */
> > > +     if (!can_modify_mm(mm, start, end))
> > > +             return -EPERM;
> > > +
> >
> > I am sure you've looked at the callers, from what I found there are two=
:
> >
> > The brk call uses this function, so it may check more than one VMA in
> > that path.  Will the brk VMAs potentially be msealed?  I guess someone
> > could do that?
> >
> > The other place this is use is in ipc/shm.c whhere the start/end is jus=
t
> > the vma start/end, so we only really need to check that one vma.
> >
> Yes. Those two cases were looked at, and was the main reason that
> MAP_SEALABLE is introduced as part of mmap().
>=20
> As in the open discussion of the V3/V4 patch: [4] [5]
>=20
> [4] https://lore.kernel.org/linux-mm/20231212231706.2680890-1-jeffxu@chro=
mium.org/T/
> [5] https://lore.kernel.org/linux-mm/20240104185138.169307-3-jeffxu@chrom=
ium.org/T/
>=20
> Copied here for ease of reading:
> -------------------------------------------------------------------------=
--------------------
>=20
> During the development of V3, I had new questions and thoughts and
> wished to discuss.
>=20
> 1> shm/aio
> From reading the code, it seems to me that aio/shm can mmap/munmap
> maps on behalf of userspace, e.g. ksys_shmdt() in shm.c. The lifetime
> of those mapping are not tied to the lifetime of the process. If those
> memories are sealed from userspace, then unmap will fail. This isn=E2=80=
=99t a
> huge problem, since the memory will eventually be freed at exit or
> exec. However, it feels like the solution is not complete, because of
> the leaks in VMA address space during the lifetime of the process.
>=20
> 2> Brk (heap/stack)
> Currently, userspace applications can seal parts of the heap by
> calling malloc() and mseal(). This raises the question of what the
> expected behavior is when sealing the heap is attempted.
>=20
> let's assume following calls from user space:
>=20
> ptr =3D malloc(size);
> mprotect(ptr, size, RO);
> mseal(ptr, size, SEAL_PROT_PKEY);
> free(ptr);
>=20
> Technically, before mseal() is added, the user can change the
> protection of the heap by calling mprotect(RO). As long as the user
> changes the protection back to RW before free(), the memory can be
> reused.
>=20
> Adding mseal() into picture, however, the heap is then sealed
> partially, user can still free it, but the memory remains to be RO,
> and the result of brk-shrink is nondeterministic, depending on if
> munmap() will try to free the sealed memory.(brk uses munmap to shrink
> the heap).
>=20
> 3> Above two cases led to the third topic:
> There one option to address the problem mentioned above.
> Option 1:  A =E2=80=9CMAP_SEALABLE=E2=80=9D flag in mmap().
> If a map is created without this flag, the mseal() operation will
> fail. Applications that are not concerned with sealing will expect
> their behavior to be unchanged. For those that are concerned, adding a
> flag at mmap time to opt in is not difficult. For the short term, this
> solves problems 1 and 2 above. The memory in shm/aio/brk will not have
> the MAP_SEALABLE flag at mmap(), and the same is true for the heap.
>=20
> If we choose not to go with path, all mapping will by default
> sealable. We could document above mentioned limitations so devs are
> more careful at the time to choose what memory to seal. I think
> deny of service through mseal() by attacker is probably not a concern,
> if attackers have access to mseal() and unsealed memory, then they can
> also do other harmful thing to the memory, such as munmap, etc.
>=20
> 4>
> I think it might be possible to seal the stack or other special
> mappings created at runtime (vdso, vsyscall, vvar). This means we can
> enforce and seal W^X for certain types of application. For instance,
> the stack is typically used in read-write mode, but in some cases, it
> can become executable. To defend against unintented addition of
> executable bit to stack, we could let the application to seal it.
>=20
> Sealing the heap (for adding X) requires special handling, since the
> heap can shrink, and shrink is implemented through munmap().
>=20
> Indeed, it might be possible that all virtual memory accessible to user
> space, regardless of its usage pattern, could be sealed. However, this
> would require additional research and development work.
>=20
> -------------------------------------------------------------------------=
----------------------------
>=20
>=20
> > Is there a way to avoid walking the tree for the single known VMA?
> Are you thinking about a hash table to record brk VMA ? or a dedicated
> tree for sealed VMAs? possible. code will be a lot more though.

No, instead of calling a loop to walk the tree to find the same VMA,
just check the single VMA.

ipc/shm.c: do_vma_munmap(&vmi, vma, vma->vm_start, vma->vm_end...

So if you just check the single VMA then we don't need to worry about
re-walking.

I think this is a moot point if my outline above works.

>=20
> > Does
> > it make sense to deny mseal writing to brk VMAs?
> >
> Yes. It makes sense. Since brk memory doesn't have MAP_SEALABLE at
> this moment,  mseal will fail even if someone tries to seal it.
> Sealing brk memory would require more research and design.
>=20
> >
> > >       arch_unmap(mm, start, end);
> > >       return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock=
);
> > >  }
> >
> > ...
> >
> >
> > Ah, I see them now.  Yes, this is what I expected to see.  Does this no=
t
> > have any impact on mmap/munmap benchmarks?
> >
> Thanks for bringing this topic! I'm kind of hoping for performance relate=
d
> questions.
>=20
> I haven't done any benchmarks, due to lack of knowledge on how those
> tests are usually performed.
>=20
> For mseal(), since it will be called only in a few places (libc/elf
> loading),  I'm expecting no real world  impact, and that can be
> measured when we have implementations in place in libc and
> elf-loading.
>=20
> The hot path could be on mmap() and munmap(), as you pointed out.
>=20
> mmap() was discussed above (adding a check for FIXED )

That can probably be dropped as discussed above.

>=20
> munmap(), There is a cost in calling can_modify_mm(). I thought about
> calling can_modify_vma in do_vmi_align_munmap, but there are two reasons:
>=20
> a. it skips arch_unmap, and arch_unmap can unmap the memory.
> b. Current logic of checking sealing is: if one of VMAs between start to =
end is
> sealed, mprotect/mmap/munmap will fail without any of VMAs being modified=
.
> This means we will need additional walking over the VMA tree.

Certainly, but it comes at a cost.  I was just surprised with the
statement that there is no negative from the previous discussion, as I
replied to the cover letter.

> > > +/*
> > > + * Apply sealing.
> > > + */
> > > +static int apply_mm_seal(unsigned long start, unsigned long end)
> > > +{
> > > +     unsigned long nstart;
> > > +     struct vm_area_struct *vma, *prev;
> > > +
> > > +     VMA_ITERATOR(vmi, current->mm, start);
> > > +
> > > +     vma =3D vma_iter_load(&vmi);
> > > +     /*
> > > +      * Note: check_mm_seal should already checked ENOMEM case.
> > > +      * so vma should not be null, same for the other ENOMEM cases.
> >
> > The start to end is contiguous, right?
> Yes.  check_mm_seal makes sure the start to end is contiguous.
>=20
> >
> > > +      */
> > > +     prev =3D vma_prev(&vmi);
> > > +     if (start > vma->vm_start)
> > > +             prev =3D vma;
> > > +
> > > +     nstart =3D start;
> > > +     for_each_vma_range(vmi, vma, end) {
> > > +             int error;
> > > +             unsigned long tmp;
> > > +             vm_flags_t newflags;
> > > +
> > > +             newflags =3D vma->vm_flags | VM_SEALED;
> > > +             tmp =3D vma->vm_end;
> > > +             if (tmp > end)
> > > +                     tmp =3D end;
> > > +             error =3D mseal_fixup(&vmi, vma, &prev, nstart, tmp, ne=
wflags);
> > > +             if (error)
> > > +                     return error;
> >
> > > +             tmp =3D vma_iter_end(&vmi);
> > > +             nstart =3D tmp;
> >
> > You set tmp before using it unconditionally to vma->vm_end above, so yo=
u
> > can set nstart =3D vma_iter_end(&vmi) here.  But, also we know the
> > VMAs are contiguous from your check_mm_seal() call, so we know nstart =
=3D=3D
> > vma->vm_start on the next loop.
> The code is almost the same as in mlock.c, except that we know the
> VMAs are contiguous, so we don't check for some of the ENOMEM cases.
> There might be ways to improve this code. For ease of code review, I
> choose a consistency (same as mlock)  for now.

Yes, I thought that was the case.  tmp is updated in that code to ensure
we have reached the end of the range without a gap at the end.  Since
you already checked that the VMAs are contiguous, the last tmp update in
your loop is not needed.

Thanks,
Liam

