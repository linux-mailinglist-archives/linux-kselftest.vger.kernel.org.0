Return-Path: <linux-kselftest+bounces-3952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B3F846217
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 21:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D135BB2672E
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 20:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429D13BB2D;
	Thu,  1 Feb 2024 20:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S+nkzNFk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PIZEmAXk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624636AD9;
	Thu,  1 Feb 2024 20:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706820349; cv=fail; b=dqU4kDRVURATLAt5RbrQ0Hj6T++pAJKzde4E7iJqgQn3IyxDfg47YCzxEwxbtz2xnqU4uExicjgrZMk1kEDHv6IBoVpA6sHUYCWx/rHj2prl4DWaJU1V2kueEQOi38lVw2yqBW+EvLl0kwDBFhV84sBb59pZaYfXGWvhxNezCCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706820349; c=relaxed/simple;
	bh=I8DFdBD0E39vJ9Zq2VyXWjPOZnzIjG1jRZxPW2wB4wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IcGrnIrmEBibjMi27uTKZrLPCiY/5ASYOFZlvt9VRlsFXS4RPkgmeCPJDbbMvJmsVk3ByeMCS5CaaVDLG8V1hQZcQDmifoMNZTqo4E2cGWOLVo44HegFeNcreQ9RyxeYdf22YURD81eKH/Sv/1NQMQlFv78eSszkfn6N4Oma+90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S+nkzNFk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PIZEmAXk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 411JEdTD008888;
	Thu, 1 Feb 2024 20:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=CHH6wRf8UpWcf6sURE0/1IgAFi3AxyRCF85p1rztcgE=;
 b=S+nkzNFk6NL/fnfg8o+mjO8Q95mEs8BTQBS6Eej/unGJCIH4KMeB+pT/qIg2gk8QNyyR
 SiR4lSqKamriiCCq2c/CEWUKK0qgYqFI/ksMUT19tGWYdby2nnl/WAJ5kG9OTc52kCBf
 KNX78WqLnZlKz2koRbNBObo1E/jmUvczy1FYLLzqo5ZJHLO2UQZwDZsubY7lepjUeP2m
 02bbSWmfwGJe/wrq2WF2q6Wxkr6iIgDX88WfdvDZ//YKuq36B37L6jbTQi+GiLH81wUv
 s3LvQRH/AF8fiSHEnuWpOuFRky5WJeD6LPBvaiLpcl7QlCbuQcMLKMpma1ymuGzfVm7e BQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvtcv5wg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Feb 2024 20:45:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 411JPDxe005354;
	Thu, 1 Feb 2024 20:45:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9gywfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Feb 2024 20:45:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q88ZMgl1ZaKUis+3ZDtS/3UsawklGEtIr7WBFvUknGpeFk/5FKXLLrmTkDNrtVCOmTd2Ly81tIQcW/MbUcEnw+hgmRVYFq07Wb9+jmunlwp/F0dL53fqdamJrUiDkufcKVJsxpQyZGkhRzJ8tkdgoaYtI+i1ZYa78ojNksvOmFt7FqhqKKU6Q85OshFOoMClT/eZtYjeI31ow5BOiAoaNP/rTZ4b1RhNyrcaVCEVgclMtpe0iFKLmRkg2Ju+mer19b3hC+T8wTPAYXwQcuSL2arWX4g/hfgVeEI40Op08R3sq/u067Wo28XsxafBwyLCxbs+ehsXZRBslTd/IKqALw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHH6wRf8UpWcf6sURE0/1IgAFi3AxyRCF85p1rztcgE=;
 b=GBaBzgLth/hzbD36O1cGOJmf7WURhOAapVnpn7zBTBVLiFXaKc4HeClrzUgP1umXK8pkCgtk87mi5ukmyakg8gLdh8yvJvkrq+YeXYB86/KtfBXXqWs1oQS9sBClCebkbFnqmn4T/ew3mCjCZb62+ZfPicSSZqto1/TBub1/N2WfzrxWV0Vexmt9hQd7rgkG4No6IQ+s3uON1UMYLA+lYtyTyplBBw+8wmHBERj9KGPUiWWGqfkInZ+fI2WYOcNSwSWnTFmQo5zSynCYFscto10oX4n4b8Arz082qlD3xeGqghfbEvTmOFldgVCeGpb0fXMqBp9M3C/HAQMAoXOazg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHH6wRf8UpWcf6sURE0/1IgAFi3AxyRCF85p1rztcgE=;
 b=PIZEmAXk/6MGGRWf5WsDVrcxQhE2yYEx2WpfjL8Jbbv7/LjTwffkTGjfYhZcUecDy4karoi9iiXrdgkvqLNb4ehPBOEZjsM6wUE738HPrf2vrX613QSg2+1L4LfBw+pv92gPR0E0fBVyb5ie4cRG+7g7bcqUcmSB+SVWWiMRbxU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SN7PR10MB6449.namprd10.prod.outlook.com (2603:10b6:806:2a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 20:45:16 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7249.017; Thu, 1 Feb 2024
 20:45:15 +0000
Date: Thu, 1 Feb 2024 15:45:12 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org,
        keescook@chromium.org, jannh@google.com, sroettger@google.com,
        willy@infradead.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, usama.anjum@collabora.com,
        rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        pedro.falcato@gmail.com, dave.hansen@intel.com,
        linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [PATCH v8 0/4] Introduce mseal
Message-ID: <20240201204512.ht3e33yj77kkxi4q@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Jeff Xu <jeffxu@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
	akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
	sroettger@google.com, willy@infradead.org,
	gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
	usama.anjum@collabora.com, rdunlap@infradead.org, jeffxu@google.com,
	jorgelo@chromium.org, groeck@chromium.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
References: <20240131175027.3287009-1-jeffxu@chromium.org>
 <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0095.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::29) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SN7PR10MB6449:EE_
X-MS-Office365-Filtering-Correlation-Id: c0cb9f71-3c8d-40a3-811e-08dc2366b18c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	10m2ks+RHCF1VHzuVH4PMQ4R9MMsqHLFwOzk9zke0gvJN30+83J4tGtb8omK9K279dl6FZvOjcgwMS3X/xD2VG0JPfSGTw5E/DHAmnzR5oaqDluwSjtjZqtiRYWvOW8p2vNqAOGAaRW46x9tCOIv66NcYx0I8U5Z8Fzy5TmSzjieKIKmpg7EjMuNbWKzFJHGGXAzSfg9PqdFHqF3WYgR8lf9y+5CXDkj5TRNzMgmkva6AtA7smthmjLxEalPZ+eKE6qahgzlyy1JxkfmlrmVnk/l7RbxJ0g568XZ4hMiBaYqXPo7CnZlmTopJEe88weAtZFgRnUyGw55sEeTDdvoNDHjJLO6aNVv0PMd44IlF6wn1BadLMeYkDeM3QM+JGDToQCylQ48FRgCRT5SwX2fSx1wqyyVPhuMEzd5qlmdL+hr65sFDY6wweDIZwyq/NVJozAeWDYDWYUDXH3ONEjSKtfPd7MucJQXG1+ZXdMs9K4Sry2w6L8MDFddMf4fFX9QASPISrYObhzo1WnnhpLJ6r7fKFgAC7EO63xLAvH+JoIJ7GilVEceqlB18qquXncSiC3QgITd+IYpqqLyW3eZ1w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(136003)(366004)(346002)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(66946007)(66476007)(6916009)(66556008)(316002)(2906002)(8676002)(6486002)(41300700001)(4326008)(6506007)(8936002)(86362001)(966005)(33716001)(38100700002)(53546011)(7416002)(5660300002)(83380400001)(26005)(1076003)(9686003)(6512007)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NkJaaUF2cnE0RG1Fc0QrbjFZbGZGTzdLc3dhM3ZiblRjSFhsUTR2WndPYkQw?=
 =?utf-8?B?VUVtQmQvdTRsTm5Udm5IeUxSNXNZc0RjWUx0OEtLaDNRN2x3RGtQQU16cFlL?=
 =?utf-8?B?bUNsSlRIRHJxWDRFSWtBeDl3dVdrM25ZcGNrUXpJVzZVd01yRFJlQml4QVBp?=
 =?utf-8?B?Uk9UTXAvQkV3M2wzNk1vaEtVNDBUOWg3RkdCQ1FvRVZjcnNOWFlsQ2o1T0Fu?=
 =?utf-8?B?dEFGTllsWlNUMFcyTjRXYy8wb3VkSnoybngrTGFNaGdld1hrTDVTbFdXdDNF?=
 =?utf-8?B?QTdGbXZaOTh6bTZBdUJScWtmSVB3eHMxZDZuREg3RmRSSVo2UjhuU3daSzZD?=
 =?utf-8?B?VzFwcERxaUg4ZjJCejN0YXBHbWsrSzhnY1IzYnI0WTU0b1owUW1OL2tVbita?=
 =?utf-8?B?bmFCMWhieWovbEMvVVF2OG53QjlGOXowVVNHY3hVSkR6cExkcHJQa3JPdldO?=
 =?utf-8?B?Q2Z5TVNQU3dpYmVlaFBqWU42b2I2ZjZaWHp4cWFIeHN4bUFLVFJkc25Xalc4?=
 =?utf-8?B?MnoxVG1QOFZYRnBBd0R3OUJieUJyUDYyZVRRd1hUK2lxaWdlZXBVZitMZUZq?=
 =?utf-8?B?RWZVVEJoSWUwN0ttM3dudThDSDZRV0JRMW9jSlhrVTUzT2o2Z0lHY3E1NDJv?=
 =?utf-8?B?aWhKdHdMc24wbGw1N2ZSMEthaytTYUJIaTRQMm95Sk1GWFhIMFcvdTNxRC9p?=
 =?utf-8?B?OWhWUGJTdGU2Mlg0a2F5N05LK0RueFJjZFMrQVJkZ2t4SkkzSGlvWnRBcktP?=
 =?utf-8?B?ZmFXbVVZSHMyZWE1bmluRVZaSmZXdVp4ZFlLQUhhVDhnRHg1K0dzbVIyV2xE?=
 =?utf-8?B?c3B4dWVjSGxMT0hIeEhXUFF6bnVaQnVRYndrSSs1eVJXMlh0RlRsTGVmd2RE?=
 =?utf-8?B?cStRUmlmSGRSTEJCdUphL2ZvVi82OTNrN2lGbHYrTDk0Tk9SRVcrK2xPZ0hP?=
 =?utf-8?B?VVEveURnc0lDS2hMRFBPRk5LUGMrdmZiTE1IWXZSRzI2R1BGK2c4d3pJb0Y5?=
 =?utf-8?B?a3NYbjlkbXZqTDduRm9CY2pBOGNoenRDVDlyRkxOSnNZZjlaOUM3RmROSUNp?=
 =?utf-8?B?MXZvZUVYOWF4dmpyNkJyb2IrT0xISGxMZlcrazNIOWRDUjZzUmlLZXEyV3JZ?=
 =?utf-8?B?NWtxVVJZdzFGQndTWjhXZzBsa00xck1XeFo5cDU2UVZsVDFIR01SVlR5UVRz?=
 =?utf-8?B?OFA4bGk2MHhETzlRdUh2djJ1VGo5eDhrYm1OeG1MOVY1cDhOejk5K1pQOFRC?=
 =?utf-8?B?Ti9EODFuWUp0TUVHOGxVRUNVM1JiVU1LK01XSEQ5emlsVjNUZUhOM0szWVl0?=
 =?utf-8?B?RnRqdTErUmI5dDljckd1eWt0aEFnS3JSZnJPbVpZWkFVdGFEbnJHcWNWbUJE?=
 =?utf-8?B?L001RU93NTJCdExDV2ZOVFZiYW15TmVNalpzMW1qSVRRZmhHVlFJeFhubzBp?=
 =?utf-8?B?aEVLam0yUGlpbWNJWFBIYndrUnMrTEpmbHdvZzZja1lvd09sMk1QKzJlZmU1?=
 =?utf-8?B?cUhNYWRnTDJGVFRjSUJQaG4vaGhCQjg0b2lNV0lHUS9IKzk1Q2ZHK3h5V3ZF?=
 =?utf-8?B?aUs1ajJVb25QTURJcnNFa2ljcHN3YmFpRXJxUDBpNWFDYXNXQ3Fwb1Yrb1NJ?=
 =?utf-8?B?M2dabjhPNDNoSUZWOHU4RXV6NDlMWXZBRjlhU29Tc2g4cWZHOGVRTDN5VXVt?=
 =?utf-8?B?WmxsR1BPZTBCeHZBbTB6Vk0rSEpURXl3bmpBSkZ5VGVVSmg0SkJ0eTdkTnF0?=
 =?utf-8?B?RXlUTnd3WmR6aStLbDBWTXdnbFJnQm0wWEJ4OVVqMTJPeWYwRUdWKzcwdGor?=
 =?utf-8?B?SnB3TGJNM0ZLb1F5clNEckI1aTZjcVQxakswa0JaQXdQeDMrNjdnb1pmQVht?=
 =?utf-8?B?dlVnWjkxbUQvMTVUMUdValVxbjg5U0lVZmJaZ3FKOWk5R29Ld1JFTGl5RXEv?=
 =?utf-8?B?VmRTSk1lUlU3eVR5OXpHT2tBbjl1bzhsRE4wQXhFa1hVaVRsY3JCNmhaOU9a?=
 =?utf-8?B?SjMvUFRhRDFaS0ZXNW9zQXNMVFV2UW1lYlhoWXVaNHFncjUzODBGM1ZmMmh0?=
 =?utf-8?B?dG5lUkF5RkZUdWl1T2x3TUo5M0ZPZHRBUnp0VHV2V3pGUmpFcSs1Z3MwMDNI?=
 =?utf-8?Q?VeD2pATomITqW9elZQRcucObw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Gc4GPDfr1qozVJTJK0mfaIbBVlURfzXdquzzmep3hpIfMBFfxUuWflU99r4pqLrq7zhzRi/9JDxZ4rt3330ySkwurKs/5cnbO8JipFpEJ5DbgRafSW4GBpVaAjh3P7Q5lv5IfOq9d53t8Ao9SNK1Hq7+kYz1QkGxkdXSFh1hKWDQJRP7LDZHffwBvNTrm/gcagNUNMOAXB6jl4gbJzkriQacRgqNzvjYu+0HXTzNRfv34G1hLMWoconxg3eYtOeRTqtRJmI8miqfgmX2rWxw7zHP8F1beHio1DWj5eblLNGhEG4/RkEqu6zTpXVAfFLg+XOkOjmeCtNfKb/FsfIGAnFCmfHP2pXnpVrJEwN5BA90Qvr3GavN48+fti7HalCQ9Kebnr+hkCfS6L9ZDfD6tkLD2RSgnIbKFmIVnG3ZZy28iMuANZvz3sKReczTEaEwxgjo4fiSA3vOkub0Dx0+HxT/iCh4X1PIYKdCLMh2Aw+85w8pTRgKWiAmhEFiBAj7a8FH2Vsvs/53HjLyFjwngxU+t/aokKHMeXZN1qZVtIOtq/+Dzndb2qZ/3YK+a5VkvAYxtMBESd7e0qc5JxlW3jyse0ObSXNnlnIE98veXrY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0cb9f71-3c8d-40a3-811e-08dc2366b18c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 20:45:15.4526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: As1gutofTgLFzWc06eH7of/kgU8C3KzQgfJ61djg+M29dasV/+0YXP3WGcr2wTYFXJmzuVBwtGxwiV+ZF/pqVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6449
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402010160
X-Proofpoint-ORIG-GUID: dVapN8b2i6I9CZqj84p2lV0IcVuUMPrW
X-Proofpoint-GUID: dVapN8b2i6I9CZqj84p2lV0IcVuUMPrW

* Jeff Xu <jeffxu@chromium.org> [240131 20:27]:
> On Wed, Jan 31, 2024 at 11:34=E2=80=AFAM Liam R. Howlett
> <Liam.Howlett@oracle.com> wrote:
> >
> > Please add me to the Cc list of these patches.
> Ok.
> >
> > * jeffxu@chromium.org <jeffxu@chromium.org> [240131 12:50]:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > This patchset proposes a new mseal() syscall for the Linux kernel.
> > >
> > > In a nutshell, mseal() protects the VMAs of a given virtual memory
> > > range against modifications, such as changes to their permission bits=
.
> > >
> > > Modern CPUs support memory permissions, such as the read/write (RW)
> > > and no-execute (NX) bits. Linux has supported NX since the release of
> > > kernel version 2.6.8 in August 2004 [1]. The memory permission featur=
e
> > > improves the security stance on memory corruption bugs, as an attacke=
r
> > > cannot simply write to arbitrary memory and point the code to it. The
> > > memory must be marked with the X bit, or else an exception will occur=
.
> > > Internally, the kernel maintains the memory permissions in a data
> > > structure called VMA (vm_area_struct). mseal() additionally protects
> > > the VMA itself is against modifications of the selected seal type.
> >
> > ... The v8 cut Jonathan's email discussion [1] off and
> > instead of
> > replying there, I'm going to add my question here.
> >
> > The best plan to ensure it is a general safety measure for all of linux
> > is to work with the community before it lands upstream.  It's much
> > harder to change functionality provided to users after it is upstream.
> > I'm happy to hear google is super excited about sharing this, but so
> > far, the community isn't as excited.
> >
> > It seems Theo has a lot of experience trying to add a feature very clos=
e
> > to what you are doing and has real data on how this went [2].  Can we
> > see if there is a solution that is, at least, different enough from wha=
t
> > he tried to do for a shot of success?  Do we have anyone in the
> > toolchain groups that sees this working well?  If this means Stephen
> > needs to do something, can we get that to happen please?
> >
> For Theo's input from OpenBSD's perspective;
> IIUC: as today, the mseal-Linux and mimmutable-OpenBSD has the same
> scope on what operations to seal, e.g. considering the progress made
> on both sides since the beginning of the RFC:
> - mseal(Linux): dropped "multiple-bit" approach.
> - mimmutable(OpenBSD): Dropped "downgradable"; Added madvise(DONOTNEED).
>=20
> The difference is in mmap(), i.e.
> - mseal(Linux): support of PROT_SEAL in mmap().
> - mseal(Linux): use of MAP_SEALABLE in mmap().
>=20
> I considered Theo's inputs from OpenBSD's perspective regarding the
> difference, and I wasn't convinced that Linux should remove these. In
> my view, those are two different kernels code, and the difference in
> Linux is not added without reasons (for MAP_SEALABLE, there is a note
> in the documentation section with details).
>=20
> I would love to hear more from Linux developers on this.

Linus said it was really important to get the semantics correct, but you
took his (unfinished) list and kept going.  I think there are some
unanswered questions and that's frustrating some people as you may not
be valuing the experience they have in this area.

You dropped the RFC from the topic and incremented the version numbering
on the patch set. I thought it was customary to restart counting after
the RFC was complete?  Maybe I'm wrong, but it seemed a bit odd to see
that happen.  The documentation also implies there are still questions
to be answered, so it seems this is still an RFC in some ways?


I'd like to talk about the design some more.

Having to opt-in to allowing mseal will probably not work well.

Initial library mappings happen in one huge chunk then it's cut up into
smaller VMAs, at least that's what I see with my maple tree tracing.  If
you opt-in, then the entire library will have to opt-in and so the
'discourage inadvertent sealing' argument is not very strong.

It also makes a somewhat messy tracking of inheritance of the attribute
across splitting, MAP_FIXED replacement, vma_move, vma_copy.  I think
most of this is forced on the user?

It makes your call less flexible, it means you have to hope that the VMA
origin was blessed before you decide you want to mseal it.

What if you want to ensure the library mapped by a parent or on launch
is mseal'ed?

What about the initial relocated VMA (expand/shrink of VMA)?

Creating something as "non-sealable" is pointless.  If you don't want it
sealed, then don't mseal() that region.

If your use case doesn't need it, then can we please drop the opt-in
behaviour and just have all VMAs treated the same?

If it does need it, can you explain why?

The glibc relocation/fixup will then work.  glibc could mseal once it is
complete - or an application could bypass glibc support and use the
feature itself.

If we proceed to remove the MAP_SEALABLE flag to mmap, then we have the
heap/stack concerns.  We can either let people shoot their own feet off
or try to protect them.

Right now, you seem to be trying to protect them.  Keeping with that, I
guess we could either get the kernel to mark those VMAs or tell some
other way?  I'd suggest a range, but people do very strange things with
these special VMAs [1].  I don't think you can predict enough crazy
actions to make a difference in trying to protect people.

There are far fewer VMAs that should not be allowed to be mseal'ed than
should be, and the kernel creates those so it seems logical to only let
the kernel opt-out on those ones.

I'd rather just let people shoot themselves and return an error.

I also hope it reduces the complexity of this code while increasing the
flexibility of the feature.  As stated before, we remove the dependency
of needing support from the initial loader.

Merging VMAs
I can see this going Very Bad with brk + mseal.  But, again, if someone
decides to mseal these VMAs then they should expect Bad Things to
happen (or maybe they know what they are doing even in some complex
situation?)

vma_merge() can also expand a VMA.  I think this is okay as it checks
for the same flags, so you will allow VMA expansion of two (or three)
vma areas to become one.  Is this okay in your model?

>=20
> > I mean, you specifically state that this is a 'very specific
> > requirement' in your cover letter.  Does this mean even other browsers
> > have no use for it?
> >
> No, I don=E2=80=99t mean =E2=80=9Cother browsers have no use for it=E2=80=
=9D.
>=20
> About specific requirements from Chrome, that refers to "The lifetime
> of those mappings are not tied to the lifetime of the process, which
> is not the case of libc" as in the cover letter. This addition to the
> cover letter was made in V3, thus, it might be beneficial to provide
> additional context to help answer the question.
>=20
> This patch series begins with multiple-bit approaches (v1,v2,v3), the
> rationale for this is that I am uncertain if Chrome's specific needs
> are common enough for other use cases.  Consequently, I am unable to
> make this decision myself without input from the community. To
> accommodate this, multiple bits are selected initially due to their
> adaptability.
>=20
> Since V1, after hearing from the community, Chrome has changed its
> design (no longer relying on separating out mprotect), and Linus
> acknowledged the defect of madvise(DONOTNEED) [1]. With those inputs,
> today mseal() has a simple design that:
>  - meet Chrome's specific needs.

How many VMAs will chrome have that are mseal'ed?  Is this a common
operation?

PROT_SEAL seems like an extra flag we could drop.  I don't expect we'll
be sealing enough VMAs that a hand full of extra syscalls would make a
difference?

>  - meet Libc's needs.

What needs of libc are you referring to?  I'm looking through the
version changelog and I guess you mean return EPERM?

>  - Chrome's specific need doesn't interfere with Libc's.
>=20
> [1] https://lore.kernel.org/all/CAHk-=3DwiVhHmnXviy1xqStLRozC4ziSugTk=3D1=
JOc8ORWd2_0h7g@mail.gmail.com/

Linus said he'd be happier if we made the change in general.

>=20
> > I am very concerned this feature will land and have to be maintained by
> > the core mm people for the one user it was specifically targeting.
> >
> See above. This feature is not specifically targeting Chrome.
>=20
> > Can we also get some benchmarking on the impact of this feature?  I
> > believe my answer in v7 removed the worst offender, but since there is
> > no benchmarking we really are guessing (educated or not, hard data woul=
d
> > help).  We still have an extra loop in madvise, mprotect_pkey, mremap_t=
o
> > (and mreamp syscall?).
> >
> Yes. There is an extra loop in mmap(FIXED), munmap(),
> madvise(DONOTNEED), mremap(), to emulate the VMAs for the given
> address range. I suspect the impact would be low, but having some hard
> data would be good. I will see what I can find to assist the perf
> testing. If you have a specific test suite in mind, I can also try it.

You should look at mmtests [2]. But since you are adding loops across
VMA ranges, you need to test loops across several ranges of VMAs.  That
is, it would be good to see what happens on 1, 3, 6, 12, 24 VMAs, or
some subset of small and large numbers to get an idea of complexity we
are adding.  My hope is that the looping will be cache-hot in the maple
tree and have minimum effect.

In my personal testing, I've seen munmap often do a single VMA, or 3, or
more rare 7 on x86_64.  There should be some good starting points in
mmtests for the common operations.

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/=
mem/mmapstress/mmapstress03.c
[2] https://github.com/gormanm/mmtests

Thanks,
Liam

