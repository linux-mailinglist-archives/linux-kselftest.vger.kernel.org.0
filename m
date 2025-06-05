Return-Path: <linux-kselftest+bounces-34399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FCBACF74C
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 20:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13AEB18882A6
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 18:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D56A27B4E8;
	Thu,  5 Jun 2025 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SSM2fUn6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y/uHDyWq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC72B27A46A;
	Thu,  5 Jun 2025 18:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749148556; cv=fail; b=rzO1cYk8jkZWPi+qULXVSqv/JvMIh1Rs5YgBzQbNKTpomaIbuk8VjWPkdIVXpvrpfpFWqw7rN0x0NyzL7AZjABzWF1tkPdOcHlRD8IgaIHCom8Ug0j077TxmvODTlHbEybXmlRWxAvzmJXyw8+deT/sfre3ptEm+ZyYzYgq5mDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749148556; c=relaxed/simple;
	bh=Fjh41zgJXG1uEV+C6xsiwDNlJ028eEOeeiHRt3sreC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GxepM6Gkl22ohoUGXAOushSObDqa5zZ/6CUxysVkZOOHlmsuo7qG7KFL1t4ThHzwL9Nc8p+aayHnIF4zzKDZa9zjpqfk39Nmpq5/+TjRQjmpY1WBcQlkLAkaE1w/LFnfKdX0M+Ikptm7W6RVq8DwXVZE+IIBF19+OLVImfpYKIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SSM2fUn6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y/uHDyWq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555FtWOt030847;
	Thu, 5 Jun 2025 18:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Fjh41zgJXG1uEV+C6x
	siwDNlJ028eEOeeiHRt3sreC0=; b=SSM2fUn65h/fMP8TT4AuSXNelzybvZi8DJ
	IKDPuGWf+1r13HXQ5SsvxsT/u32iu5LUxJxn4HJCWiZcD7kcLalgtYi3Df1Tn0eV
	/GTNMn5XV0Jo0vb+s+axLsw4fNSVTQOw/vLVHfGfb6yr2/c+lwgDb+aFwqph3XZH
	gRdQ2iVJ8BcuWnNGq9TgWBm4sRl2cLM8DQT5bJaIN7CAfWOAll3ZBMlJ7BM++VdH
	4ShIhs8o1Jaxfo5Fl2Bm9AI+Y3ui+5y0GL4zl4bbk6rMYBnPSQU0UkJip3Xx2RSb
	pWHV44UnkPJI5ntdeNc5gOadpWiuiISWmdFwgpA7GH94TP+j3x6g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471gwhejke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 18:35:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 555I45Mg039164;
	Thu, 5 Jun 2025 18:35:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7cf1kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 18:35:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1LOwa0TC/bcRha2JKqXYFFy2yZkQZ1dGI7UkTRGRmG/X8guRlUgA3BN0IWMSa4ErKma7CPZ/lRCGQaCHN4uJ/dCBxKoLJ2mCQ+3MyIuF4eClI7CTGTMVpct5O5Fddf83KY43OHcIvetbdERO+ICEKfmpCoRJ2DX7jSfrTXoxfm1bXddu0FSxBth0MTDk3SuGlw4LfKth8A65CLC0XvBqMOmElMvLEWlA1xzzUgUUNxtPLEj17Ua0VLmekm4Q0jDErGEfDAIhEleBk+mTtWdX9yr2ygMUCvPNF+3r500MhA1We1CkNrK+LvWcuxOu1omKbhCsTUVgHx+tW1SmYidQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fjh41zgJXG1uEV+C6xsiwDNlJ028eEOeeiHRt3sreC0=;
 b=g6K58m3dyOCeTpMAGBaZdrSe2uFFx/Vn6NSHEJ1s6V3SimQb+Dgg1Re6+Nh0ApyjbjmcCkkHlrfm+cUa6U2R2OA3Mo/aAtyAY4xd0UMsjvCS8NjxZruVh9WyJ6HSj+YFGDb9XUhj0YHE2jfXq3z7W1oSSFMYYLiFrPzMEu2HtokLM1t4bbCaOE0qyZWPgpPPoWLwDIwQn+qeJdl5xMY97B8w/evi/+L1K6JWovBPNwlZTNLSdz9LYrtUk1iAj4y/ORElpsGytV9cDqXxIbM6m2Y3/kKwVZaiJQ9ONPsD4URvelLuimRSyhdDqtba2G0g2pU2OECXlrt8RHmkB3vXHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fjh41zgJXG1uEV+C6xsiwDNlJ028eEOeeiHRt3sreC0=;
 b=y/uHDyWqxorlED8ZbRZsp7AnFisjAFRjG2s0pPewmTwmfTzT9WhbC3y4r2QUCx8gB+wt50C35/OAkP9CKqzPFwzkxWwsX20IqeLgaQANotCk9jRNjG+0HoYAP9tOWYfFiDIJpEAENABaCpeNgjpEEymcAFyGX1wl0xBPI49GRTE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB6996.namprd10.prod.outlook.com (2603:10b6:8:152::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Thu, 5 Jun
 2025 18:35:42 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8746.041; Thu, 5 Jun 2025
 18:35:41 +0000
Date: Thu, 5 Jun 2025 19:35:39 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] selftests/mm: Fix test result reporting in
 gup_longterm
Message-ID: <cfa1a27c-60f1-435d-a4d6-425d0b262ab7@lucifer.local>
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
 <20250527-selftests-mm-cow-dedupe-v2-4-ff198df8e38e@kernel.org>
 <a76fc252-0fe3-4d4b-a9a1-4a2895c2680d@lucifer.local>
 <722628a8-f3fd-4fb9-ae04-2313a52ffb36@sirena.org.uk>
 <66db3d9e-73a6-4fcd-8abd-db65cfff49ab@lucifer.local>
 <661fc4ce-839f-4c47-bc3a-0c864e846324@sirena.org.uk>
 <976bbe1a-ef16-4006-acac-8b6be46ee5ea@lucifer.local>
 <961a62b0-d0d3-40db-8008-61c634172ca6@sirena.org.uk>
 <ab2e1fc5-a0bc-4694-9449-adf85b96b38f@lucifer.local>
 <fde974b7-de82-4a2a-bb8f-efa9955d50da@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fde974b7-de82-4a2a-bb8f-efa9955d50da@sirena.org.uk>
X-ClientProxiedBy: LO4P123CA0336.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: 1254af00-55dd-449a-e650-08dda45fc685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qq5IozsfiWwL6LemiqOTIPQ52gBFwXql3fbVPpxc154le9bVhvGFoX45xz6A?=
 =?us-ascii?Q?xfRK7pl/HvVYW43GeNVzNa9xoiTXYg6i6/bDa2eMj0wMHg/TU66oeoVJct+H?=
 =?us-ascii?Q?06OGz4uEHUZ5fnCqAcTkXaufpsymE9RMGsk6xWeCUF5HS1UYwk2TR00TleTo?=
 =?us-ascii?Q?1lmIXLkQ69IWQ2F4AbgkIGd4AdnpA57VM2/I8go2LppnDgXXWHXtaczD6iTl?=
 =?us-ascii?Q?2bgbIKskFqQYYIRROFBfJ+jM54Iyk31eX3xc2FzhNV4sn6exrNzjmZx+Rqkv?=
 =?us-ascii?Q?atc3m7WFYQvJZuuI5on4qyN5nkwR9D7tH8Het+UjGpLge/a8yM9TiOYTp2/3?=
 =?us-ascii?Q?Rm80TAwuZPSvydYY0kNd5PFUDTVT/71Z5Elcor1rEjasV7yabkmx+9Zqf2Yg?=
 =?us-ascii?Q?BrF2anFh8qKuTnDr4l30hz74dvFoY1eWJyj0SxWw+dmly8vYVv66ErFHVr5X?=
 =?us-ascii?Q?HGGS3i7olzAJatu3pKxPQHESHI4Fz3qovgxz4knGMq+sLSRfbrJkmIkQ+5qM?=
 =?us-ascii?Q?5QLbNM0on5c7aKM96zf0iXyqyQ0W9VQM+9ACkOpnmrVk9u2uFec49Pfow+Vi?=
 =?us-ascii?Q?mWm52jyhJQOls9db+ccAXuIrLHDEyu4AHBJiNa4/BdWT4rkACTFXGobFsabM?=
 =?us-ascii?Q?6ZswVydMGP+3cSt3wnqFhyLMBYGRG5dzqcm9fESWC1kslu7rFPuC+w65j0OV?=
 =?us-ascii?Q?hN4xb+KUtckd65aqtDFwL3IlITaOhdcyj70TMsveBQj/CHuKsT7btB0QLtuO?=
 =?us-ascii?Q?IddFGEnLlIWFdblGMnESonN++1WJSlz4ZsIKYJTlcO3FcrKFU7X+KozUG73w?=
 =?us-ascii?Q?G/xKy2C+VBBTeVIf+wFeYhk9dZW8AwXlX6V5hnizoYihT41LCJOspRSF1w6c?=
 =?us-ascii?Q?foZw9tNf69tWNjNa/hJx2ocqGRWgcj6kbXB8RvH93NyW/x4mAJ9kQzvUktz/?=
 =?us-ascii?Q?r9KnxOBmxMhv6AGEdYJTjAv9DCTBrx7dmjnVa7z39c2MTVA788PYVtp8H+MC?=
 =?us-ascii?Q?NQXzQzcvRq0XZVsX2vGp78Z2MQ/BqzMQDnI9VLsLO/23tTuZO9EK8tHPL3rw?=
 =?us-ascii?Q?qBkWFwe7qAVkCYzG5fhtt5Z5Vj3OW16vOoYwjnDlLgXaVlUlQtVGC+FdxqGx?=
 =?us-ascii?Q?CkM7/UeZ61AmV6mFNtPBN/J52gcWRS87sZs2ssvo28iTXP7fqoFyAuaGQOdR?=
 =?us-ascii?Q?aaBqvtZKITgTPgXVI6huJSrJ+iQufJxQbQl8stgyxJy2R1bkKsHxV2dVQCUf?=
 =?us-ascii?Q?a4HPJWcIPTmjKZBNAfzvJvqZr+6CbwfTOCQBTZ/ekLvgru8aBPJFlbWq7ykq?=
 =?us-ascii?Q?NUk+7nkRNhxWD45AHuyY9YWZubEIb10U0KZXdth04b/T7l/xyfNFPZZ6A20+?=
 =?us-ascii?Q?APh+rj06ilyiyIUQwcDwLtHC3zuJQItUkYf4AY0VVXaUZLOVhw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VzblEEdNm7QZ4pwen8Do69Tgr4lUqMGXnFIVwihOzBDYCwZfb1uiTVXlWBKO?=
 =?us-ascii?Q?t14S+sEhSugg6i3UW+0Papxpq6ycYOvMUXptn+KHDmdAvIFfA14AisUI1hvM?=
 =?us-ascii?Q?K1hx+a7GvzSXPqHrAwF1eMAHoHywRdCzNRHpSjr8c1T5mG8bxTW3/RUzfvBS?=
 =?us-ascii?Q?t02EoYvJ5Jbtdpl8ocW1bcSPFJSUU6K1epvhSSWGjOCa/N8YAP7z53C/O2l5?=
 =?us-ascii?Q?qZxPsYLNgKGX+3Z2FJHq7DXxxbNgihwPVEgwd4Vidtw5jc3Mw+jp+u4ozMr1?=
 =?us-ascii?Q?j3l5W2gWm1JGY89p0OBkW9YG7epY3yRpYdG1GL6/dxQ2llupR3UQKaGLEzeU?=
 =?us-ascii?Q?/OVwMD2zHejJv9LfLITLVrghcB2Wl3hGc+sdsdvr/5ALe/+4FvMw+lkBkNY3?=
 =?us-ascii?Q?czSL9/GQ+GxsLbScyJKxAD8kqNtdPX2SVhsWk3vuublkD609OARLm80pU8Lc?=
 =?us-ascii?Q?I8l6JnEevRA9Blcy62ezPHR3Us0sVa3NlhIs4tWsvxl3ave9JvWL014YFPiM?=
 =?us-ascii?Q?Es+j2rMO4nPrcS2q6QSbAzzv5qaIB7KAayfjn3Uako8i8qMAdN2o7wmlw6mo?=
 =?us-ascii?Q?ZNQ1kosu4LzoUIGa1I/5HzMi9ubWzth37sQiwLq4ZWUM9yuxE97sqM/Cvt97?=
 =?us-ascii?Q?FQwWxVmyBmOd5N1FTtOkHfW8/oXYiUcLrleX4k9nrO2iMf67oKFtebCkqLHB?=
 =?us-ascii?Q?wFCMhrbR/nt6BgL91JJav2I30SxvqLAjsClGNZ5wesVbVZ2sDylGH+g2cgFS?=
 =?us-ascii?Q?UNhwcsAqFHR8aCvhpvT0EENPckjrnCVUH5wHwNmqVIGs44n4YrMQ5iE5leh2?=
 =?us-ascii?Q?qWZKUUcrwYbxduBTA41+hYK/T/RjeKmpvp4hJLKqnp94vXgfux9lCz/0qwuK?=
 =?us-ascii?Q?Ryxkn4mxi9DuVLuyUWig9kcby2Jrqoe/aKPNJbmN4jzTKmNf1o7Jb45mh0Wd?=
 =?us-ascii?Q?vyxt0E1jmn2ucrQrt01/W/tU9FZ30EbDmfWtANKEo4LPZYIWse9b1P+v4XeU?=
 =?us-ascii?Q?RPJkBx1OdCZPsvbkj8MkyVhYnHkJLregM3eWEbJuAdqufFCZ6KxbA4wGBhU6?=
 =?us-ascii?Q?/jK0FMHTUVwN42pUvwTYZiwX5hPcpTdcXHpdLMSSj5CSOuozrnZu4aapyd+k?=
 =?us-ascii?Q?dfCsPEVFKYh4DwkIfpBMxGlxrtJFiDFEh1QUcVP5XgFzyWw/g44pvLQGXw/E?=
 =?us-ascii?Q?vnokECXGVy4v86usXot0ynV3ZCMJJPq7tDUP4I7LQ3L3A7UT1Y8CtbjZIwvY?=
 =?us-ascii?Q?EDY2D9PlXkoURXZK8smxpLffhEYWjQJi+8duaPogEmaVRp7o3wiyT7eXdaoY?=
 =?us-ascii?Q?MQ9pGkyXHjVRyVtsUtqxbgrkykHiRzsza8QHAI4huX4UqMOeLxkeR8rI181f?=
 =?us-ascii?Q?sQ4gqy0WrMz5C82F1+KdzOF2LduzU5PAPSaVAbTNQVDEWm6eSImhf0LGKRxB?=
 =?us-ascii?Q?gcGwcCuNV2Z1UvecuF8WkgtqMEA7dds7/Geg2x3p9rqZHBxFzK3QclTOxed4?=
 =?us-ascii?Q?m7l/0Omlh0O15oOgZl05UICTDqCo5JFnbtAwNc3RjwU49DbXJqHvKLphYx8C?=
 =?us-ascii?Q?wybs+yGAORbxUD+fnC5eMrz8SdppM71xBYdM4iA+sh2RlKrc36RhWSAeSvG1?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jKSO5Dvf+kjb1TOoFF6iGPEers0hVAxKT/w/Ykyoz8CQ8gtbe3BT1by4CwbAnK6Wv687ucnWC6vPCz5hEcLd5RgraYfqqu/wNvudugTMTo/RBuOpnD8aUVKJYiwPecwpO/VmfJGO2XzHdYw931Tl7k+rf6SL0o37RrYfDE9gdHYZzeGWHbNWQczzPOZuJ8LEuzTFc8Mf3E63lsIep2qbANWXkbPPm685h9+4EFbHxhZLBnG1W5TSaukpY5Q9+3vkcJYLwqvrlwX0Vp4ViopXj3sdgO90B16q8Uus6Jnn0UBgPzO+DgmR3VPrncoelFY00dt93YiEGE8g0Zyg5ibW4ODkUF8Lzir8E5sZOFuaSS8fhEYPNMnadWmS+JWPL+t3xF3ds+IcFclHO/y/msHU1b1MxyXW8VKiIARWx6XOYkiaUXlAJ3bW/aRbOAAXa0M50RiSBpFNEpnFQ8rzCHNv3clch+hEvy48UagA2wRInwOxL3w0QCWMgeihYnYTiVdMjivjDhI7IeXmlemKnqJAW7r/suuAJEO0ugJ/4H2BXXNFGv+KAPg78Rh7HKhIzCiihm6HuYQU52T+YCdKaK7Pq6kpEnos6H9UcZmbzJ8KmU4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1254af00-55dd-449a-e650-08dda45fc685
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 18:35:41.6883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkJdEFe5d4lq/WT/Y5u8ZKh3l4OyPtX4ImKwQFbPPuOj9OALDQC7UE1Ii0DbUZWqv07XvtDVa9mH+7AaiifPUDrqwsnq+fk6JSfuRsE5R4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6996
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_05,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=642 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506050165
X-Authority-Analysis: v=2.4 cv=Wu0rMcfv c=1 sm=1 tr=0 ts=6841e381 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=Uh_TffO27Q2DjjrFxfEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: S0vCsZcVdx7YPbdpjP6_rSkMPMxzJHVi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE2NiBTYWx0ZWRfX5i4K1Z77I7ZO Fp/Kf36O0fkV3DKCSCm2YLfpXXnbRWrTQbg/ogv8ntS0Yfhv/YJV0ZxyUJIgBkv3mz64MXfgwg1 ppC54sItbjxaBQAbqqQNdmTlgLIMqOBSdQJiB85S5m+9wcUV9E4kBo27RN2fz9fqGGhRmy5D/l/
 RkBfXFTOFujCdFLZUvekXq5U8H7nJET+z8Vb6lz1xYG7iYYpKY5Y9mYsFc18wIbawv7Pi9kZXYN u+9x3aY1m2P0w90QoIO7J3hXGgVwAb6AjVoREhrcHBGqJfWPPCJVfKtFeeeUGDqNssZsilglKlr DLeCIJbh1xXd1fJSyAnoMbA4GtvpbteNhLjW2Gz0OkpQsvuIvRuS1J9KGJ/ASiZbYDGbstlCEIW
 268evllwW8HGX0mtgtXQBVYG6mFZtSZbcWZVFwhuwpweil1XQ1q5tyjb2rRMCAFWP0ljC+LV
X-Proofpoint-ORIG-GUID: S0vCsZcVdx7YPbdpjP6_rSkMPMxzJHVi

On Thu, Jun 05, 2025 at 07:29:58PM +0100, Mark Brown wrote:
> On Thu, Jun 05, 2025 at 06:47:28PM +0100, Lorenzo Stoakes wrote:
>
> > Mark, I'm not finding this productive.
>
> > Bottom line is you've broken the tests, please fix them or if you're not
> > willing to I'll send a fix.
>
> Sure, like I said further up I'm just running my patch through testing
> at the minute.

Awesome thanks, appreciate it!

