Return-Path: <linux-kselftest+bounces-4018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CEC8472D6
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 16:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 378FBB253D8
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 15:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCAD145B20;
	Fri,  2 Feb 2024 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WPoESbbf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T8PEeiMj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5271960249;
	Fri,  2 Feb 2024 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886859; cv=fail; b=YhsudjaiCODQEK8VjqwD7SCYKzi3JekJS3/onOp3an35iIpD8cgtul9YXmlv1XYyAX+XG9/7KMj8/CVmrgeS7tX90opZLm5OjB3njWPF9RG6SktpUbBiqCgktxvbnXMt6LNdLf98i3QMJKwZPsTUKa+O47fwHuYJj6IuEdoDznU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886859; c=relaxed/simple;
	bh=1vnL2X3kRcvUOTWRDp+/yu+XP87uB2SAt+l8bTdY7Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KJdrruIM2wttFO5a7sty02rlHeJxTnu6OznBjmWIDtpLrzLjTdC7uRznki2sIES878R8WwkjuOHtILrVzmSsALTCp3rqb5YAZ9r3mf7VAMH8BggmXyDjopg4J+MNQvbVNBeM5bn4V3mItmuC1Q5loxOzXvdcveAwWkXZzRDSLoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WPoESbbf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T8PEeiMj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 412EYJo2021737;
	Fri, 2 Feb 2024 15:13:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=LJaoVzgq3QBqw24L6jge0gux5ExTqxJAROAvXJ9qN9I=;
 b=WPoESbbfnEt3tqjEdxdSVikBcFKBBj5ck8YA3m0VZYkjViALVv1TmH/hRTdD7uS0D57X
 j4K7uyO6HoRq7ahIJzM7OxJnbEcrXgrDZLLsF2LhdWVcTF+jIDgExLKuUw6VxutmiDn0
 2mCMKdSM+Fk/GqYUq0CEQKjyKBABs501mN0Eh9txPsZotr+F65Lf5UxvGuT0q1pclbmd
 Dc6RlISSthYpPcPPq6JBhJiFhG8O8OvEWMHud+2gy6vgLQb2haqVQbVqM8SwBkCeS59n
 D7U+yxYdIUcKq7CeoRMS/qxxja02dLo1TsZgVHu1UaVul3p7L4St7DW+BlLq3UaZEqPt sw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvre2r0fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 15:13:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 412Df5Ud019582;
	Fri, 2 Feb 2024 15:13:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9j2eff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 15:13:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbHdE1NQRymkIkLtF0YAM/FttY0HCjeukvwCAX6Zp2/B2gRn1Ng+IoTg7JPxzPt8AOU/kkirW7YV9mzvvp5t6ow6CoQkuySo9C1MWP0gHF1VUUZhjx29EbvRz4XXeeljOKpeCnHDFNov3gVoDXu7hRZZcUsNixT5lbx49FYglh1XJEMZR4zgSkTTXF0gooUc2qnKk1rQJfCm6pBd6EmjuZ/rX/WylvGE6Xz0bkHti3gQ1NI5+pmW++bYSMDf+NOWYbAN7SNhKwqzLZlgy0RDBGpBlNEz81LvHvu2dPMem2JE0WsacxKHj6PjjgfC/dd2efHGpfu5TrXIayVXyGnm4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJaoVzgq3QBqw24L6jge0gux5ExTqxJAROAvXJ9qN9I=;
 b=Nwldu/QGHBz5WJDQrD75H87eHX4qLuk+6/xzNlQfddjfNRwIVRT0tXNwaFDjxR9OGcEZSMLfNQKBiTWuIQDVXxsH51gMACqtELWWnzMOlvGCn+ib8Nd5SSnhwLM23nPAyWZmMPS9sUysy9or9JuJBZ1jDm4stkDVzuVjlXHxMO92WyNsFJYPXUVqQ4HQM/ORaV7fMhgUhxjXrTgeaBITD8Kbs9pUP6LnpZ5HYgFzPfWba2PqdQ9LHst8Dhb+eze2kv8TUVbfMw5Yp/33VddTOV/NCeTX4c1xVZHH2pkfz6lrfNAd+wpiBg0ZaxRiCSBNx9tHlIBM0uRF1xSt76oJBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJaoVzgq3QBqw24L6jge0gux5ExTqxJAROAvXJ9qN9I=;
 b=T8PEeiMjyt3txrQHSJ1leyYK/Tc9S5K/p77ogQu/mYIb/Qnc73TNnlsCK1ARWx8pp3zJHHNPLssUBFEDgh96b9hVj0LAEk7fYt5/tgMHY0AwjpZISyzz9raa5SRNaerlGKlMAumbm6eYnbBeCrvm+W1WbcTb2r+r06gorp9Qj24=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS0PR10MB7936.namprd10.prod.outlook.com (2603:10b6:8:1b6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 15:13:48 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 15:13:48 +0000
Date: Fri, 2 Feb 2024 10:13:45 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Jeff Xu <jeffxu@google.com>
Cc: Jeff Xu <jeffxu@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
        akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, usama.anjum@collabora.com,
        rdunlap@infradead.org, jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
        linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [PATCH v8 0/4] Introduce mseal
Message-ID: <20240202151345.kj4nhb5uog4aknsp@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Jeff Xu <jeffxu@google.com>, Jeff Xu <jeffxu@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org,
	keescook@chromium.org, jannh@google.com, sroettger@google.com,
	willy@infradead.org, gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org, usama.anjum@collabora.com,
	rdunlap@infradead.org, jorgelo@chromium.org, groeck@chromium.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
References: <20240131175027.3287009-1-jeffxu@chromium.org>
 <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
 <20240201204512.ht3e33yj77kkxi4q@revolver>
 <CALmYWFupdK_wc6jaamjbrZf-PzHwJ_4=b69yCtAik_7uu3hZug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CALmYWFupdK_wc6jaamjbrZf-PzHwJ_4=b69yCtAik_7uu3hZug@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::12) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS0PR10MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b12bed-1a63-417e-7295-08dc24018e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8PPTPJvGmA63/Zc187FnNYXEBBKvdCk7Rh3WtjjAWnl/diTj+UJHx/FLkD4F3IQjC5VBIsrFjOCew2e3upQUb6WbYXxABs5nmj1iXblcAcIMj0DaoPa/aOrZkUPbsfRTNQiMof/qrlsgzxBZ0NO8nT+5I5cTjsdGdRI8MqBCiTJK/51N7fz8O3uYs/97Ny1VFrJEnf4y5+4UdGoiSchCpcvwpfyPSpdD4B+dAgZpPfhn5aNA4JNRpZw9h4mNiPTMsucgWKSQhGX1mJ1Qt9QOBC08fVGbi7f9rgOZIPrOX7l9lW0InC8LTn5guEoA5YEqckVpA2oZVY0scD4qX+bxdhXvqVTVbVW7dUPRayUpzU2aFWt6gvMACxkDoh48AkSpg1REoG50jQRSL0epreCO1wPrfcO9/dK6u0BocpfDEUprhrUwPFOOJDyv/XAhKEfbScvP8fYGGjzM8nBBxYeloJKZN7YWxOjN3zfSgzak7qi/Fv6PUwOHLA3S5UDdC977Gk0z5yzVQVS3ekbJkslu2UTCEs6oERTuwrj4jNI4AeEBkrHepcylyrW4l113rMSD
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(136003)(366004)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(1076003)(33716001)(6512007)(9686003)(26005)(38100700002)(7416002)(5660300002)(4326008)(8936002)(8676002)(66556008)(2906002)(53546011)(478600001)(6666004)(6506007)(6486002)(6916009)(54906003)(66476007)(316002)(66946007)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OUh1U0VYZXFDWWFud29mWFVtWVByUk5tYm1QM2NaVW9TZ250SHVMZFZ2Mlc2?=
 =?utf-8?B?TUtnMkIxVWZPdjl6ajVwOEVjcWtpcEt4Y3NRS0FDMCtEMlYzZVhsaTA3TjIy?=
 =?utf-8?B?c283RmFvU3prSE9VNGlqbS9vOVRFSnRwR2g4aFpKOWp2MkVzdmg1WE5yTzNN?=
 =?utf-8?B?Rng2OEQwME14S3EvbmhwVldIT2ZvZzIrblhSSTBZSjRmZnNiN1M0WTVpd3FI?=
 =?utf-8?B?R2Z3em4xTkZJNTlMbTZReEkvRUNxeFRtYWYvWFdyTGwwZDZpY2dyYTZCcSt4?=
 =?utf-8?B?dXJacXdUbld4SzF1L2ZZNXlpazc2SE1jeGYrTndnSXlrYSs3U0FiVzhCbkNV?=
 =?utf-8?B?U2ltUTlJbFBRT2dFMFUzdWtNWnN4eWlOSUVSQzJYVFFsbldIU05OZUh5VVF0?=
 =?utf-8?B?Y2o2YjRERVFrYzA4ZkFSNmdGWDY4NG9MZjRjd1h3ZVJJQk85eHhRS2dQUkxX?=
 =?utf-8?B?cEJITVA3YkQ3K3pta3pvbk9NSUl5RkVzSlF3UHpDWkFnYitLQ2NhRjloSFJU?=
 =?utf-8?B?a2cwcUxnTGF0amw5UjBucXlwM2tkQmJhRlIwV2NuV1FWMVlQYzNsdGMrSXds?=
 =?utf-8?B?N2ZUOFhYTTArNkowM1I5dzg5VU4yVFRIb0ZpaWZUbWN6dWUxVVI4L0x1MkZk?=
 =?utf-8?B?cHFJSVRoQnRnYUpvWVErekxzWXRqNmN3UU5qTDI2YlFUb3hydlBjSVdVSy9R?=
 =?utf-8?B?QW9JenVCNUcrS3hhZFIraWJEUFBWZXhmWlpCWnlkVW9sQWNFMldJb2Z1aStj?=
 =?utf-8?B?MmxkK0cvamw0MmFFWWR4TSthdjEzaWxnUENIS3oyQzhHdERicjFVcGpWSlFE?=
 =?utf-8?B?bEsrUWl2VEhNUFJyR0dtM2oyM0R0UUhhUFdTRXB4OUQ5SDlOeVhnSFlXLzNS?=
 =?utf-8?B?aEE1Tnlnb1pjdjA4QnhEdEFwWFg0cDhJOVJrbVVBd0E1dnZLUmlKOXZmdlFH?=
 =?utf-8?B?Q3g1Wm5SRDdrSUt4VWU5YWhyd1h3bjNnc1ppL3NaMUdHWEhveUhNZW10YkZa?=
 =?utf-8?B?UEliNUlhUXdUbU8xTDVqc2Q0Y1NZSEZYcDlHUGx4emhrc3h4ckF2d2tlRkgy?=
 =?utf-8?B?cGhTdXVqTURTVWhBbFpoaDFwellJVWROM21pWTJZQm1MVXdyMGpWU0cwUnhZ?=
 =?utf-8?B?MXBRSk95RlFyQXhCOVY2cGNyWUIrMUVzek9MZnpLVlVBVDJZQnlqaE5ZUG4w?=
 =?utf-8?B?VWZoUWZWQm9pSjIxcXlZcFFuSE9VaHdqd2JRMHhWVEVsOVJSRWhTeDhpL1R0?=
 =?utf-8?B?b1BkTTEyUnZmMTgvTi9OYWR3UVZuMmhOSEd5UHBTNEpGdW9RNGZPemJyY2xv?=
 =?utf-8?B?Yi9zamxnZXNJc1lmR3JqUTc5WnovTHRXb2JrOXIyZ1hqSGtJcTkvQjllVU9K?=
 =?utf-8?B?U2R0VUtoWHV3OXJGTlBYTlBPVVVPY2k1dVFMSWVxSGtFcUl4VlVQZXNLakF6?=
 =?utf-8?B?K3Fhcndhcm9MRFhGSUpzdVFJQVJlbEZ5dDVEOGJTRmR0VXlMN25CSE1PNCs4?=
 =?utf-8?B?Y3Y1UkhTRTE2V1Fibk13ekFJVlQ0SllnV0tTZlpQcXBsbTRoQ0Yra21oV1h2?=
 =?utf-8?B?NmtPc3U2ZXM4L0N1TmJxajBLSTlKRCtjQ3B3NlRmVTJUdzJSNTR4NCswVXpL?=
 =?utf-8?B?TG1XNzluWVBaejQ3NXVDWm9hVEQ4MU42aFNKMUJXQ1E5V28wakdhMEU0Q3lW?=
 =?utf-8?B?Yjc0WDVya2pKTlBMZEpRZVhkNFFNU0FGUjRLNE9vTFd0eExGeCtXSzU3WUVR?=
 =?utf-8?B?RVZValVsSEd4L2ZsWXRVdGh5dWVHYmQ1SDFiRk5jaWZTUEpxeDI0SEYwV01r?=
 =?utf-8?B?VWZSTE5MdWIwZEcrMU5vSUE4QjU0SlpPcDFkT2p2ZUNrRE1jTENUb2hodXkz?=
 =?utf-8?B?N3MvR1g4M3hQL0hNeDhIYnZDLzVmZEN1MldmMXlmaFVsZlNTY0M2bnFMVkpa?=
 =?utf-8?B?WUkwNEVPYUZnWHNtRlpWTER6Z0o0WUR6cStTMlI0d3VpMTduRW5YSnBXUFZJ?=
 =?utf-8?B?TW8ySmo1RnVUWGhNUWFFL29LRHBQNEc3YjlKZEgrSXpLL2JpR053UDFwOUg2?=
 =?utf-8?B?cTBxUnBSRW54dkRMSktUQmx4RXVWeEF4QzhWMnZmV3pvbEFFNERWblJHbGJm?=
 =?utf-8?Q?O/x3jh8SzahBRT4hHKME3LgCj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DDGijZK9cR4hTfTeOKOONtmE1YTdLy6e0ugtPRgrt3DOoQtz6eA2S8T5UcXE6U8HffprtPaLiZJaO7l0x/gLUzd897lJ0qwZNNAMohfAZlHRmzIy9XqqKcvhE6A+fRUCw4ck88rc6GjjSKdNq/7WSO90wJ576u9pempf2cifbwmuchvyIKOiA96fkgMuCuNFZxHhqMEXRymqKunxf1LFBCa7gKQs198DwwTMlDD3iD85zl+YEJyPYxeHp5gNji4hPoc6DnRXdRwfx4Uwn1vd7bl/VZ30nKUodpmvrlMbxpshE9DF11goUZ9T1azN1WpIF4OKALXUZXe9fnrWMSNURDG/lluOR0kgz10CF8JNZNk69gfv+ABbZvjezl8dQUuF29bO9zH4xhAaW6i2LYy+0xwV8AI2rR7pOUx+8/x/K+VUiBuuSRXzLCsWBiO8beQQrz5+21ghFQabgM0ymwGSQnmXbLIEqZM6gAwckBxmKV/mLAVIolQgsbRyLlkT09KEOIuiu9fGQs2AO7bmRck+SzCcrkNt0oXyDfBbfhzvmqce9aO/ZOAZJVAGyXHyfXk230RzDBMAH6+Qb9knWOiJ+uVcjpvQPoy6bc9a6w6H7KM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b12bed-1a63-417e-7295-08dc24018e40
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 15:13:48.1773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELw45EwmqXYlQvqWvt0xMUQj9DjMWu14ycVWv+8Ml3XjJXtPQMFrk2XF9TUrKC4Binmizh3nGZNU9Lw9n5bnew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7936
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402020111
X-Proofpoint-GUID: 83JZCNRAPxdiVxXefdkCy-qrNwnzNeTX
X-Proofpoint-ORIG-GUID: 83JZCNRAPxdiVxXefdkCy-qrNwnzNeTX

* Jeff Xu <jeffxu@google.com> [240201 22:15]:
> On Thu, Feb 1, 2024 at 12:45=E2=80=AFPM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > * Jeff Xu <jeffxu@chromium.org> [240131 20:27]:
> > > On Wed, Jan 31, 2024 at 11:34=E2=80=AFAM Liam R. Howlett
> > > <Liam.Howlett@oracle.com> wrote:
> > > >
> >
> > Having to opt-in to allowing mseal will probably not work well.
> I'm leaving the opt-in discussion in Linus's thread.
>=20
> > Initial library mappings happen in one huge chunk then it's cut up into
> > smaller VMAs, at least that's what I see with my maple tree tracing.  I=
f
> > you opt-in, then the entire library will have to opt-in and so the
> > 'discourage inadvertent sealing' argument is not very strong.
> >
> Regarding "The initial library mappings happen in one huge chunk then
> it is cut up into smaller VMAS", this is not a problem.
>=20
> As example of elf loading (fs/binfmt_elf.c), there is just a few
> places to pass in what type of memory to be allocated, e.g.
> MAP_PRIVATE, MAP_FIXED_NOREPLACE, we can  add MAP_SEALABLE at those
> places.
> If glic does additional splitting on the memory range, by using
> mprotect(), then the MAP_SEALABLE is automatically applied after
> splitting.
> If glic uses mmap(MAP_FIXED), then it should use mmap(MAP_FIXED|MAP_SEALA=
BLE).

You are adding a flag that requires a new glibc.  When I try to point
out how this is unnecessary and excessive, you tell me it's fine and
probably not a whole lot of work.

This isn't working with developers, you are dismissing the developers
who are trying to help you.

Can you please:

Provide code that uses this feature.

Provide benchmark results where you apply mseal to 1, 2, 4, 8, 16, and
32 VMAs.

Provide code that tests and checks the failure paths.  Failures at the
start, middle, and end of the modifications.

Document what happens in those failure paths.

And, most importantly: keep an open mind and allow your opinion to
change when presented with new information.

All of these things are to help you.  We need to know what needs fixing
so you can be successful.


Thanks,
Liam

