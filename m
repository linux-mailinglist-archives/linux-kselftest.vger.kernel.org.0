Return-Path: <linux-kselftest+bounces-28062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34267A4C425
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 16:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EBC717114D
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 15:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86F121171F;
	Mon,  3 Mar 2025 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a2OtM74/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HhvbFRxu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E31156F5E;
	Mon,  3 Mar 2025 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014256; cv=fail; b=mzNShNhdId/XJF+S1AQIZedot1zou+dWr3/NCFvvi/4iuYKtaKyUo63vf35hIM4ooJ+Uydqn+9q62Nw8XeLqCdGuJEGlEhC51n64hdpqZm7clZAbtulvEgdnBAi2JYgqKsYmNuGK1AlQ4XfUJQefstwYt1xGUD76EzetA9LfYX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014256; c=relaxed/simple;
	bh=TpOdcQMcubgGtiJUSXH4LVQXsqsMtgJLhvj0VeJeWPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J4lYDZDRHf4Ytz48ARMzd5kIGM40Hmamg2SywQGLLg3Dbh02rioCXXs6iVqBxJr8SOVrkgNUsdhNpwTt5gIk/Cfn50II2sb0uJVEhSlTlSgh1BdKvG/PxIi4YM99sHX9WL1WpzlaNNQeMBnvIwa3YLNjmugYVLyxGLwxx5pNHOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a2OtM74/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HhvbFRxu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237tptT022699;
	Mon, 3 Mar 2025 15:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=U7Cq7Jc0J5iicmA7Y9
	5t6iaTTvW/BIUZY1JyO6FKzXw=; b=a2OtM74/dRPqeFKxBN2ovQeykAWI9Qp5hE
	EBoP9NO0C9dbixd/bQefFxYNxHD5QbLVrBTFTYo0SVRWgIfXGFi77VSuwRhd22iE
	KjzyULhVcoYwpiEYVQrcPBHm1SvGH4GvKbcvGGCEo8QuwKw1ywfoRcL2vexNKHiU
	y+hPUWu6BuwP6vOHXhfU82eNnFzrUKHz5S2CsdexTY+MxRiUhxZqJW3ff1JLJXrm
	DM5cNqj9cYBmECF5lEA670ryo50rCmT3McEBGfSpt3NLhiP+RPOWjZAEsREUWxbp
	F3BvGQGM60ZjjFrRqI6pm/wXBxu6EgCJKQu/XjAaaVvlLY8R1fhQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8havkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 15:03:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523DcW6Z040462;
	Mon, 3 Mar 2025 15:03:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpduwv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 15:03:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1LfU+oyNWzaY8lmq98VSWd2k1ghDqd7JyAMFUyVDLgwdrgr9dkddjaWrXqOKfiwswH/JbTX9zyORnk+OA8iaUwSBS+s2MW6usX4hwAwNu89f0N85aTrhQAHAeKsmHfx7hX6a2XxurdNs6JaZZIUDjCla/GPTwTBkjl26Wo96G9rhtWm9i9G5bSZQIBhJFeFQNnuUXxHY1KDyyTwKIhAX+R7BokBhbjM3ynfeTZePtNVh5f6JdRkwx20KFXRhkWNRyuvnZdEQ+G/0yUBXeQAsPqBG3mQpf0EWYV4PNUv48do6I2BDM8QRJ0HxuG1zMOmW6D7ZJTYHbASf+Wf2GtnaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7Cq7Jc0J5iicmA7Y95t6iaTTvW/BIUZY1JyO6FKzXw=;
 b=gtW3Tv7hjR1A0RSCbIztfZzEn3lu08aKkqzUaPN88MmG4wZf9kBVfDWIVsg2lM3g8skR4mwrkw/pdEiW2OZBE5yqMq/cb2zZVIhU+8BgpBLgSUalgy1hXqDhVvJx/pIXJO/bQIvzno0iDVk/m79wemF6XN8Xi9azx1Gw/EIkEjReyzMWGr5jYXdfNxZ2XLAivnmksG/vIEfUeLXq6fIKvF7retlHCC8sCyFvvLmISCz5mYFvzS8iWsJu4mB8g6yIkh/WIqdIwU/FQEhNT6XXCyRBouVx4T9YG/hE/pPasw6NXtgTaQCx+IUKcEt+TKqPigBWjuFU8aJThr0c0+CHmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7Cq7Jc0J5iicmA7Y95t6iaTTvW/BIUZY1JyO6FKzXw=;
 b=HhvbFRxuGjoNKqcfCvQ3qj0CG4SqvFJY8t1S1bQCdHEbjoqwkqq/MK5MBjyA2huBJwuRYp2ejprAf0n2p29+9rfCmjIpPjdfdnaLmhXZVmtIWkQKP4xjE/rmjW5e+59jnD0todeuydZ6gUhfZHjPXCm3hZ+SdOeu0ngzXq6oKBw=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SA3PR10MB6951.namprd10.prod.outlook.com (2603:10b6:806:304::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 15:03:21 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 15:03:21 +0000
Date: Mon, 3 Mar 2025 10:03:14 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        torvalds@linux-foundation.org, vbabka@suse.cz,
        lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org,
        oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        jorgelo@chromium.org, sroettger@google.com, hch@lst.de,
        ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com,
        johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com,
        willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
        f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
        mike.rapoport@gmail.com
Subject: Re: [PATCH v8 3/7] mseal sysmap: enable x86-64
Message-ID: <zbpdyg7zx5gspkqzkbivu3rgs6unninreljijezp3vzwsdnadl@nz6et7gidttx>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, thomas.weissschuh@linutronix.de, 
	adobriyan@gmail.com, johannes@sipsolutions.net, pedro.falcato@gmail.com, 
	hca@linux.ibm.com, willy@infradead.org, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	enh@google.com, rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
References: <20250303050921.3033083-1-jeffxu@google.com>
 <20250303050921.3033083-4-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303050921.3033083-4-jeffxu@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0112.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::11) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SA3PR10MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: e57eb523-c003-48e5-bce8-08dd5a6489c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7G7fTi+MI1Ktd1Hi0wv3RB4HKO1rINzICImwWzHAUx677UCIfT2Lwvkk4led?=
 =?us-ascii?Q?i1s8wu8aW1YtPflBIAX6LMr5mR4XlwJJlewoDPU1G5ANMl1Cr7tGpSP5r2AC?=
 =?us-ascii?Q?+CwrcBRPQhUhSpmKk4BsVNVys5S1vx8KzBk7ch6a8a4QFguX88kSMI4fSFZF?=
 =?us-ascii?Q?Em62OzEwyTp/EUTpmXtbtzBVGnd+SuwJ9oDA06aXNBfTW+ZDwpx505kFJPei?=
 =?us-ascii?Q?rS4G+Su77ue/pKvioJ2GeINeZ9f3VgcoD/IqNisSgn3wz5/PMhqkVVtM9pk+?=
 =?us-ascii?Q?Fp7VT7q76ouhS4BTuThc1mj865fIJR25IZ+TK+xyFN4B0yEtqL6+DPqncSaU?=
 =?us-ascii?Q?5KCPvS3ZJXo2TCKUl3SC4HAn7ESfiB4dRlTj8QkAR4e5Ki/e5VgPk+KMM5lP?=
 =?us-ascii?Q?AH0m24Mzhzk+J4+cKSZ4gcx+3Y/3RdNkqeAcD8MNYxoAeXsIwl2xJRQHX+Wq?=
 =?us-ascii?Q?7YqBw/C6Mpm3NUagAUZ4ju76Jpim2h+HaSoh6e6vSSAT5Q9p0tjf5+AYIkKi?=
 =?us-ascii?Q?/dgsXYdbsDgVHXh45kPKQ+nw+n0RzRWpApmS/69B37NfEMclSLcqfeYFX/t5?=
 =?us-ascii?Q?1+M2D7I4xyco4kGXdVsIUVWCAwUaoQBBWm+auQ9qHqWlfQq5OYDX+MXyy/Ec?=
 =?us-ascii?Q?PY1PZUKaoXeMczIK/z/LEVx7tOSFjIFz30ibW0Cjf1VRtCH6lLpfGpt5HvIC?=
 =?us-ascii?Q?8ViIzJu0ihTXbURyxURDMW2uM9fwpKckOyrSWxpyX2HkWgX2RM7zRvTixKeJ?=
 =?us-ascii?Q?dXpxAJ3m9pX0G+zjDM1adGBdk9szB+gellLyYn/91Z7crQAx0gOhOBdU7VEV?=
 =?us-ascii?Q?YTmbUmG9yWmlEeT25PjKwY0r6sW9YSBzcjRHkiTyTpUrUYEvepFpgv4gWt13?=
 =?us-ascii?Q?Zb5TMbJgEP32uXMJBliZoY1qOjg3jBwCNO6DiGb9IqYFFo0MYuaTwyEvygSw?=
 =?us-ascii?Q?BJXxPq3J4lHzAgHCbGhEXRenRm3HsRx9mQbyXrh6CCnmlq2Dc0orlVzoPuaU?=
 =?us-ascii?Q?djDQqVevqsW76QdoUlQ7+z4+reLwbW4TaT6AN6UCPKqK1HZLRaY4h7Dy4oAp?=
 =?us-ascii?Q?ogukw369t6L2uxI8t3Pxu8oH2CRxVhqJzghC7KE2oJGmbmkD7KYfM0Nmpinp?=
 =?us-ascii?Q?pvYYmEC2tqhhMDTFHCYrsFi/vwryrBGKAF5Mn+z/n4C5TRpntOllvo/kBL1U?=
 =?us-ascii?Q?5EodJ8QqirZDL/iBuUtMX5BiyxazQHsmGczVEUPD7maDVKu1cyvyUQ1qjIyq?=
 =?us-ascii?Q?ET614cpfQ4SXolz2LKuXAOOFT4lx817nBMDZrXGLPmLw9wFMmc5kgssxvuws?=
 =?us-ascii?Q?GAAyBbdWe4Dm5JmmrqdfOXyvynKoEDmEttChCLzmF+AtM5cDg/m7AbVZsONt?=
 =?us-ascii?Q?7l5llunclwg60L9hMQJZ9y4axrRi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qdQC1eYf27bXAI6oIBcH362r1jD6a8/L+tasTLZcusR+k8K20x1dqNcO2TfA?=
 =?us-ascii?Q?sxbqqdd3p8VKWAlfODbgtJ2NWeFu1u5uByWfDOPQoDzKKW+0Avfkbw6TKRVr?=
 =?us-ascii?Q?/M0fm8g9U1twOhovn3xrY0b2W9TweJFh6057b87RKLsIo12PIVh7Q27BJlmJ?=
 =?us-ascii?Q?4PHBUS/m/1rSHeE7mea0N+VXLGJ6AACaDEjyWMwyHHMGkaQUZvXXQKJ9Ikng?=
 =?us-ascii?Q?7gPKxQyRDBaL5Iax7yatsfTAi4dVy/roX7qtNmmlMZFUmFdeb537VNWV0A35?=
 =?us-ascii?Q?yz1NIi8Or2chug6IOs5Rs9OfIQffM1GNJbcXT8ob24xBz3aQc0lcag4zO3wn?=
 =?us-ascii?Q?DWKeT7yQq7irJx0/uigFNFUoTr/JiNGsgKY+VvH+Mdo3NLx4fY9kZGk7yfea?=
 =?us-ascii?Q?Uv16C56OiPEgh4H5ObZ7e1q9AuNY4HQtx2TjZW03QVHNGH8CUAxR150xIYsy?=
 =?us-ascii?Q?5Z7O6gVuRS4PRGt7OWsM17KEb3eVWwKk1/f5ZhoxlUXNtwWQw1YS6hlIPt8c?=
 =?us-ascii?Q?yVHlgcOVGFB/IMEFKASnSDEg5lJoKb7pgHs6tUCeAqBLIj5N87gDBEByVjLM?=
 =?us-ascii?Q?sf4O2tniX82GyO9Q8V+HwZRo2YFeIFLmYRjE5G0kTIW+x39yDasdLlFFe+Wl?=
 =?us-ascii?Q?1auYCiua80rWtJZttemre9j6i613sddq9vpo79nxlkyr11Fv6PvuH12QzyiV?=
 =?us-ascii?Q?5Bo2zcsBqX0bgKNyBJIVsnJQ5WQdPs7EUgPGq0aOZ1jtwOa8aIzIVI5JoWqt?=
 =?us-ascii?Q?pEfA/K3MONq6Dj8nlh9mQbCU0Xnz9JPFG2qsNbzeP5446y/VdqaflyMTRFvC?=
 =?us-ascii?Q?nxkQI7+ZABxXAfQGwcbKUOtUA8WS3b+Vk/D70WQjTSEZX8g8oTsOxaa8WXhJ?=
 =?us-ascii?Q?922CFSODq/5iu7EViA/9cKDDuedcxzxn++pQVhCKKUlCI7eghIKuGymct/xg?=
 =?us-ascii?Q?zNwtaRj4oBxAeUOTGlL67OvyVQdToehWpnEJFCNWSxiRLP1R8pwdgdcJv1Jw?=
 =?us-ascii?Q?k6fZ8UR2t3znk+5tfXYwFkceU/AGFiNHzHnkss2ht9gWW6sG0gGiVtTj3uG6?=
 =?us-ascii?Q?o/rd8IeL1ObVJ2uyU7XHbba6jBOY/2QyH73GPJc8+xQCbNSunx/P5xr+hx8I?=
 =?us-ascii?Q?md74zFGTFBzw0jhWfK3cTBS8y/W0woyw2dZm/uy7V+wSA0jDqf3mkovuN52M?=
 =?us-ascii?Q?//HTjSYc3XavTr9u0LezQjVm7qBQukVQB3zqmpO4t4Iiwu6l3j6vzT5RUeNf?=
 =?us-ascii?Q?ReFGmoBO95thk1C28atyHIy8GVxnXS3GzLOj2t56lFNX8VlBxZMqmveUDT56?=
 =?us-ascii?Q?Jpb/K81bqNcZcsw7hOoJQDa/7YmbbCum3B2C3qgbS4bzipw1ZGFTWxZLIgLO?=
 =?us-ascii?Q?5mA7VBOky9Yg7eY8NBAo12WAEGUoGGW0d2WPjzu0JlQzdbAWwSuTG/SfxGWh?=
 =?us-ascii?Q?VrSpe8j8wdO39kJ9dfGc6EnlH3gxH6oo4yd0d+GuLfadYUfXdqSSatXhxft6?=
 =?us-ascii?Q?j3/U8qVdQbTTqPjt76lVcf2Q8FIzuryiCwhaAHXYJWq4m/ysUvy2rhm6fENz?=
 =?us-ascii?Q?LSerb7XQu92G1d2D1iCYgd1zyVQqTG9Dnfg+q0M8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nSdbkW410wtUb5LkySRAGfnZAyMKHe0eWXb4sHHbm+y3fpKg4pR5FBum8zIIV8s7j/OOLbgcYiRFtYHqdsSFuVStlc68ETKNXcd2fTUz6Maw6JDDo/XGmLFFZiy046okd2NUqFwMLzxVyEk7PMEvVRGM6td195jdkI/C4F+C8liGOdxg9c6c5q15ziPwHJriel0xtJk4Gk46rE31WDEElV9ofeTxfHM5raa0Qx+jYxvxrB28x5fMzseAz7Wmc18DBP/8JiPRVXUL+MFB7lYWG6koNVWD3hDW18sPJnvJSiLj+A9bQ16FXUO9yGkNL388jMlW8vbrdB7aCi+jctgTmR7Yc1HjZPrmoo6PHQe4XjkUzO998CV017RHxwW6Wghop9ew9kRYlzXMd4E9Up4VU6yRiZLNDL/gXxjBhLEQiZnUhw09ylfygFcjne85cC6xk2TlqpgmC5vHPKe/QEhBxjvgJDZxPTSAyxD/yLrvnTgy8cARGcU4UHz+t/7mLGl8Na5FzaEW/uFGdZ2lM09qR8jz3yU58q3I+qmfnDYDScGM8IuFo/SD/d1Yy1sgKO75TGD//dQFIIGLjD5En2+Geb7CzjWAIe1FdtXLDAWvw1k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57eb523-c003-48e5-bce8-08dd5a6489c3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 15:03:21.3379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+Ge8pT1w3wkvSvIqpkldvUc6wymS9UTswelL5vYIJHUFgw1hZ8f+oSEJYlYf9H9wJgvqdWf8hK0ATjm16lLMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6951
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030115
X-Proofpoint-GUID: JNoYCRETtkurZnqZx9CORHoBXph1hPKT
X-Proofpoint-ORIG-GUID: JNoYCRETtkurZnqZx9CORHoBXph1hPKT

* jeffxu@chromium.org <jeffxu@chromium.org> [250303 00:09]:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on x86-64,
> covering the vdso, vvar, vvar_vclock.
> 
> Production release testing passes on Android and Chrome OS.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>

Thanks, this is much cleaner.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  arch/x86/Kconfig          | 1 +
>  arch/x86/entry/vdso/vma.c | 7 ++++---
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index be2c311f5118..c6f9ebcbe009 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -26,6 +26,7 @@ config X86_64
>  	depends on 64BIT
>  	# Options that are inherently 64-bit kernel only:
>  	select ARCH_HAS_GIGANTIC_PAGE
> +	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
>  	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>  	select ARCH_SUPPORTS_PER_VMA_LOCK
>  	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
> diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> index 39e6efc1a9ca..a4f312495de1 100644
> --- a/arch/x86/entry/vdso/vma.c
> +++ b/arch/x86/entry/vdso/vma.c
> @@ -268,7 +268,8 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
>  				       text_start,
>  				       image->size,
>  				       VM_READ|VM_EXEC|
> -				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
> +				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC|
> +				       VM_SEALED_SYSMAP,
>  				       &vdso_mapping);
>  
>  	if (IS_ERR(vma)) {
> @@ -280,7 +281,7 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
>  				       addr,
>  				       (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
>  				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
> -				       VM_PFNMAP,
> +				       VM_PFNMAP|VM_SEALED_SYSMAP,
>  				       &vvar_mapping);
>  
>  	if (IS_ERR(vma)) {
> @@ -293,7 +294,7 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
>  				       addr + (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
>  				       VDSO_NR_VCLOCK_PAGES * PAGE_SIZE,
>  				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
> -				       VM_PFNMAP,
> +				       VM_PFNMAP|VM_SEALED_SYSMAP,
>  				       &vvar_vclock_mapping);
>  
>  	if (IS_ERR(vma)) {
> -- 
> 2.48.1.711.g2feabab25a-goog
> 

