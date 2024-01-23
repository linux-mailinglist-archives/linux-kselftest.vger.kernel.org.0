Return-Path: <linux-kselftest+bounces-3428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B39B839681
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 18:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC321C254E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 17:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0294C7FBCE;
	Tue, 23 Jan 2024 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MVPB1zmz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YYFvmVyS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA155F555;
	Tue, 23 Jan 2024 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031239; cv=fail; b=Gy6jSMvx1w90yHkFxyoxExQZZT/4BdnvsQJo3M2rWiXsBtbRN1sANhinzKq40f6cI+Ig4EQwG9CtA7BQAgXT2Gj25leh5Pc2CQAYNrOHMnOp1J/XUl8QQems8yL6JfS1ePfkDYz0icNqB3HcG5GKCcLBkmLEws+veJZ04c4nkDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031239; c=relaxed/simple;
	bh=7wk2iM6I0busVTBhxa0ophdJHPWGOUVzdTkuCEGNXPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V2jjz4sdoexGF+T5k9gzzjmGBk4HEw4WpZGXulJD1Qqutc72EoGsRANtkDbRtdLuUcHow71vqdw8R9Me2DkvoehQemPPnPS7FX4Nrgn6U0AAWVRNnMQ82DbIDJm9vu/OKqGE7SDbJ8LJvGV1P8oWuudbyuLq00sf4KbLtjowEr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MVPB1zmz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YYFvmVyS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40NGRSOp029574;
	Tue, 23 Jan 2024 17:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=CthyY6/IRQ0zhJM5JdpkxDz3oqebol52OS4+VVHhtH8=;
 b=MVPB1zmzwwCJ2TzxeAHtvvZwONLWbNvq0hBXVy4ahOExOAi4IBzH1+oJwGE18r9lXcbh
 5z2UrYJmDa6s05Xky2ZZOaoVCpdESMNvyfhHtpDz98jXgeRVfJaLHXpMlnrs2L9kgI1+
 mzPVqJUAPlQ0K45qEk1EQISppxqHlDFCTuAbhPgebAgkCVlSXwpYxRByUb7uSthwH8S5
 pwJJOMeXCZd8kSLdl/6Xzc+w988cJzfek+SWBcY5GWzuJB9GH2yeVjN4L+Jb+KhTP3dl
 e5VUe8YJgDFiJgzURHgAWsTA3NFoJRE6sgt6M5SgMNSd08GWC3mdTypGwSbrCl7xz9L0 tQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7n7xy9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 17:33:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40NGKaTa040800;
	Tue, 23 Jan 2024 17:33:25 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs315nbb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 17:33:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkwiingLYRSLVh+ml/mJZHS8T/WOFxG0loIlBpPErX4Vco+YEPAzF7wBPBkLwCUYOJYIQqlISN8X6x0GIS2w+QpqDUka5pfPbcfYydok5B8ZipUf9THHloyPL6lyanuqmLwbIfVv23xp0tL6pckmYKtPcYQLchcE/ULr6h+WudVlRHS7T0OEbMFcg9slIpRLU3/rObwwwAcTUI5EehOJhdj4WzPMI3K6Ac4yK8mxsSlplmXyVrs3e+vYf5qhooHv1Maxhyrwsoqu7AQcm/XT3i+pzdpjHiKPmjgIDo8rvIeFIe3o13sCdsjdidjS0HIwqOlYEF91uSgj+XkyU63R4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CthyY6/IRQ0zhJM5JdpkxDz3oqebol52OS4+VVHhtH8=;
 b=RObZ2sKv6omnYO2ncxk7YJfyKGQnGjLD0WDpWpy1fEuKzMcN1pvF0Nc7t8zs4+CtSeOw9A1RgILa+eW2DfPeccok6F33NefLzpAG7RSX/e6O14iRbylLSMUiXcw4WaTKxiMChI3s3Q3yPW2uKCHwXiV53VzrDOi8OixqtpUdTKEd0acM3Ot7DmP4/wgURFmRji9qm1rTFiQQARLhhqKBkxtY2iZW2YiryLnIeeYrkKdvptoTR1UdMENTpTKZMKJmpfSDL69HQ8KAM7lO5UcTjlCM55jvCZr/x7De+pwklW6rGd/60ccr26FOwUY3BbpGNwXVLMPZctlvhtszInNMLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CthyY6/IRQ0zhJM5JdpkxDz3oqebol52OS4+VVHhtH8=;
 b=YYFvmVySYUJ6sfTUeEEhPoIqNgmXrbpZQAoHPl3FWZI8KREsQt5ZY8W74PwFKSlUATfbEgizH6971eEUP+mJtIn6pt4QTUkD4c9Rr8sN4+1hhPBsbYRxdlyGXvTIqJuUQbFVExSEK2tKzKtEWcvor8a9c76RlleS7lfV6cH3y6k=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DM4PR10MB6693.namprd10.prod.outlook.com (2603:10b6:8:113::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 17:33:23 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7228.022; Tue, 23 Jan 2024
 17:33:23 +0000
Date: Tue, 23 Jan 2024 12:33:20 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Theo de Raadt <deraadt@openbsd.org>
Cc: Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org,
        keescook@chromium.org, jannh@google.com, sroettger@google.com,
        willy@infradead.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, usama.anjum@collabora.com,
        rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        pedro.falcato@gmail.com, dave.hansen@intel.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7 0/4] Introduce mseal()
Message-ID: <20240123173320.2xl3wygzbxnrei2c@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Theo de Raadt <deraadt@openbsd.org>, Jeff Xu <jeffxu@chromium.org>,
	akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
	sroettger@google.com, willy@infradead.org,
	gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
	usama.anjum@collabora.com, rdunlap@infradead.org, jeffxu@google.com,
	jorgelo@chromium.org, groeck@chromium.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
	linux-hardening@vger.kernel.org
References: <20240122152905.2220849-1-jeffxu@chromium.org>
 <726.1705938579@cvs.openbsd.org>
 <CABi2SkXrnUZsWvpqS61mHw-SqDBOodqpcfjdoTTyeeYG9tRJGA@mail.gmail.com>
 <86181.1705962897@cvs.openbsd.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <86181.1705962897@cvs.openbsd.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::20) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DM4PR10MB6693:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e10e8cd-2830-4c90-b8ee-08dc1c3965fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jPw3iM26GoFvDdsgRpRmanzrNg4RHROLgSHOWe3srxAp0KDKXkKDenH0TUNgHbqEdzBG3X9W8Cee+RNZNNhhjM1aVLL8ifgcpc19QZeb7KvF8O46Nm5P/tyWPl+KZ1du0hLXkKFzayC6LElII0PxIX8ChOfGvak0oHM5K3nSP9KPN91bhj/QfaI9vYNWaek4ScO/XQKAPZFME+IYVehPhCRBoQcLWMfzhPSuSDoLZjY5DhRnYw3uZFFCxebSuUtWO0YV29SA1e8pEToMitRUyhP9b3va5nhMJ6oD8CgUYr+LFsnWJxI8GRAQqIjgSmd1le6AxTr0cSxN1GzHv3fYTREa7GRP0Pva9s2EpIpb24pQywsjvP9ShaA6N7ZljENFrK23JkevtfI/XBWPz0QOWI++TcLCjnTotjaKZA/ZcS/UXojLdxgC/peWqrvx+bugXB3cqHnhYM39WGgpzsyBVOHltNmdAckKC2IHYbLg0JEzK8wua/vin++EQTdTdRQ0uGOxHYM8YfwVKtU2Xm92cdRqz7e+rgT52FJjlMhU+wA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(41300700001)(8936002)(5660300002)(2906002)(7416002)(8676002)(6486002)(316002)(6916009)(66946007)(66476007)(66556008)(478600001)(966005)(53546011)(26005)(33716001)(9686003)(1076003)(6506007)(6512007)(4326008)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VGVYaXNNZVJwSldGQ3hoL0dlR1VJanFrRlEyR1Yra2F0NU11bUE2M2cwYjB6?=
 =?utf-8?B?RXNrejNFVWpvN1kvSUNHVHpTNkc5eDNEZ0JBU3VWKzZ2Zm5yeHdyOTRhNFdN?=
 =?utf-8?B?QkVqa0dIQlh3MWZvN01lemMwTFB2VUU0bTlJYkVWN1lyVUhZcE5NNmNNV1hm?=
 =?utf-8?B?alNCOFNxV205ZCtjM3NxWUVpalA3d0hSaXlQZ3hMRlgyWGIzeTV1ZUhsQjUw?=
 =?utf-8?B?djZIMFZJWFV1d1VJYVI1MVI4RFhFengrYWE0c2pKb1RBdHZnekx5Qno5U052?=
 =?utf-8?B?dk5LWXVnSEV1aW5HRDdDVmVuVTN0M083MXJuTFFhOXRMNmdXUDAzc1lsck5j?=
 =?utf-8?B?S1hmOTdEaEhmWnFNblBDL1hCMDk3SXg2UU9FOFcyeFFsa2NoOFhINWJLTGVG?=
 =?utf-8?B?MW1WRlNXQWRzS05QUVZyb0I1TWovZEpFQjNEZUxDbGVmRm84S2FrK05iaHBI?=
 =?utf-8?B?NmwzUmxNOSs0NXVDUlZhRHVQQUpMa3hNRThKWllubU1CUmQ3Qkg1bFFtaDZm?=
 =?utf-8?B?M0JGSjdiNldsZlRSWlRqaXBMMGNkUmpsYTEzbW85V1RIQVN3YWMwZjVFVlFU?=
 =?utf-8?B?alR6dThSMUUwTXVJQzB5VW5oUFcrbWRGaWtiQlVQS0o1eWVKYXRMc1BXZTFI?=
 =?utf-8?B?RkhyaWprNnM5QzBUOC95Y3A1ZnRsbUh2QnEwT1VCeVJnQUptMHV1eERvTmRD?=
 =?utf-8?B?MzAreGtrU3lueG92U0s1eCtMTEwwZTdQaEIyVTlXdWNaZXBHc1U3Y3E0cU5q?=
 =?utf-8?B?ZXlhbmZ6ZllEem5Lc0pTRFhaQUZmYmlucER5V0xZemhtN1hsK2UyWmFNU3Js?=
 =?utf-8?B?bkw4M3g4QTNjeGF2ZjlacW96YVhnUDkydUQ5dmFhSmpPZXNFUFFDSzhJMG96?=
 =?utf-8?B?QWp4a2ZIRXFiSnZUM1UrUFVBOXd6b1VNQVVWOHRXTE96MHpEK1lIYS91Skhn?=
 =?utf-8?B?R05ickRPa3o2dzlYa3prUXgrc0NzSWd2RmMxVTBqakVYYUJjSDJJR0Rudkxl?=
 =?utf-8?B?UWRsck03cDJuRzZsam9WMk9QLy9sdWpuRTlvcm1WOGVmaGFkOE5ITXgzRnpt?=
 =?utf-8?B?ME5yL3V6WFJINlhRZ056MFhxRWlqME9NeWdCR1VpdkdlU3c0UHUrdm5ja2Fj?=
 =?utf-8?B?RThFbFJodXk3WFBMZktrSGdvcVVUTStCRE5mYVhmQmtvb0IvZ0s2TVV0c3Yr?=
 =?utf-8?B?cmlydmlvcSswaFVQMnpRUWp0V0lFMStXTm1FUXNSdHBHM24za2FqSjVaOGUx?=
 =?utf-8?B?VElOVHJzVGYxSWE5N0NNeDRjell1Y3M1Z1piTi80eERXRG9CVmRLWGR5a0li?=
 =?utf-8?B?cFJQcno2bDRyNGx2R0JRSlN1WjU2MDVLR2dXZXdMZUt0Mno3c1Z3ck5JQkli?=
 =?utf-8?B?YTd0bE02RnhaWFdvYXdCbFZha3krSUVLT1pGZ0Y1OVpwZy9wOE1iNzBVZGlG?=
 =?utf-8?B?NktvMEVESElrMDFCR24rZ1dwYWhuU2g5NUFpb3V0cWhjRUtOeExRR0gvQ0VU?=
 =?utf-8?B?MkRUQ3gweE1hNGZmOTI5bG5FS1hMQVp0SlRWczJDb2dMNnZBdEhBZVQ0UzB6?=
 =?utf-8?B?NjNLck5Yd0JuVHFBS0syNTdDVmdhQ0J6K3dxSGpDMVM1QlhWck5YUFAvdzFX?=
 =?utf-8?B?RkJ0Q0Y1REZmMmtnT0VUWDJ6cGhGUkhBSlNPTThrNG5mcUtwYmlXYUxyd1c3?=
 =?utf-8?B?aUJ2dUcvT2wrQzhEYlJnOFFGRnBwSWdOREpXd2NpdVV4UTl1REdueXBNY01t?=
 =?utf-8?B?VlNYS09KTUFKeUlGRklNK1NYQ0tJVHJNeTFJa2F6RDc2aC9GMDJIRDM0d1Iz?=
 =?utf-8?B?dW9BYWtLRHhDZUVDMTlQeHNLdjJHckVWNVJ6NnYrVkVvWDZxK1VIejIzM2Zx?=
 =?utf-8?B?cXhkZWhqbHZPeEdBY3psNVhVZCtFcnIzbm1OcXRGRmxqZ001NmVocGdzSUhw?=
 =?utf-8?B?V3FianBMUE5lbmpuYmlQenEram5PeXF1RDdzYUl6SWtnTUl1djNLMk5RNGs0?=
 =?utf-8?B?QitXeUhySjZSTUZNTnU3eWhBdWFXdUVkWTVWODU0TlhYaFR5Y2dqajBFcC9o?=
 =?utf-8?B?ZXI1TTBlTmdVRk5JOWRZTXZRU0Y5aHlTd2s0dHhEaHZEZFhTdHRaVzd5d2sr?=
 =?utf-8?Q?yZIs9eSoemNuP8I0i8T9LHVyo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PvLpFS9djU3mH44+9KQCKdCv1A8c3HqtRy4VG/D2e6TIGEqPchjE0WlfQ35rfffqXEnTIR2Mxe/zp+Wgn4LBz+bu2JbcJjUomHEc2GzcHkkgSn3KJvVKmUjEQtw7ffsInmXrb2FewOm6Ugejg5np4Oai+mAguHW2uFkCuEsz9SS33n83om6I1VHWqbcT9yNQH6uFsonRYdU9KhBJ4Q8ASbCVzcEoQoKDu1rNstcoC8N/8vbkUy9Q/F0K382nn52ZJyjFyWTmoZ1V6VSdOd6pKptjGVxAMleRQSD7/U4n6MpxVN8akTxhcdQSQ0SqHKeoYbv5yHtd2lY5nO1aRVTFmOdt8YyFMCRul8M7PoETzWVWazVaNxHdrrzQ8ezsZJRJTp7qRbluzzEcLa4DNfxpTM71aV4HrZSsks+Nd3JD35fovF7dPFF4ZJTFy+4EQr4bucfT6VJoQ5K4jplRSBYcuQLbuoXAWdbVhkd8fpvaBn+aNnhoKOprf9MYz2wt/2iL5zv7aUyfT1bKVppW6LNq+WzXIvzbgpwe8f0llZ60vQIaK332Fj0MCVmMmSRRPToQJrNFfj9ScEe2x4E9TKC6zK9aYwfjEwQWHNPt1T9E2+Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e10e8cd-2830-4c90-b8ee-08dc1c3965fb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 17:33:23.0870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xY7Ybwxl43AA23TI6raMLzaOtzRfJsA8A80iYUDOly7aXCHBIItmVXze9xhpxefSsoS2Mz98fFAR+aDJmYj7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6693
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_10,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=893 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230129
X-Proofpoint-GUID: 1VUUgDAysAFPhMuVfJdGtsz7VeWmdvW1
X-Proofpoint-ORIG-GUID: 1VUUgDAysAFPhMuVfJdGtsz7VeWmdvW1

* Theo de Raadt <deraadt@openbsd.org> [240122 17:35]:
> Jeff Xu <jeffxu@chromium.org> wrote:
>=20
> > On Mon, Jan 22, 2024 at 7:49=E2=80=AFAM Theo de Raadt <deraadt@openbsd.=
org> wrote:
> > >
> > > Regarding these pieces
> > >
> > > > The PROT_SEAL bit in prot field of mmap(). When present, it marks
> > > > the map sealed since creation.
> > >
> > > OpenBSD won't be doing this.  I had PROT_IMMUTABLE as a draft.  In my
> > > research I found basically zero circumstances when you userland does
> > > that.  The most common circumstance is you create a RW mapping, fill =
it,
> > > and then change to a more restrictve mapping, and lock it.
> > >
> > > There are a few regions in the addressspace that can be locked while =
RW.
> > > For instance, the stack.  But the kernel does that, not userland.  I
> > > found regions where the kernel wants to do this to the address space,
> > > but there is no need to export useless functionality to userland.
> > >
> > I have a feeling that most apps that need to use mmap() in their code
> > are likely using RW mappings. Adding sealing to mmap() could stop
> > those mappings from being executable. Of course, those apps would
> > need to change their code. We can't do it for them.
>=20
> I don't have a feeling about it.
>=20
> I spent a year engineering a complete system which exercises the maximum
> amount of memory you can lock.
>=20
> I saw nothing like what you are describing.  I had PROT_IMMUTABLE in my
> drafts, and saw it turning into a dangerous anti-pattern.
>=20
> > Also, I believe adding this to mmap() has no downsides, only
> > performance gain, as Pedro Falcato pointed out in [1].
> >=20
> > [1] https://lore.kernel.org/lkml/CAKbZUD2A+=3Dbp_sd+Q0Yif7NJqMu8p__eb4y=
guq0agEcmLH8SDQ@mail.gmail.com/
>=20
> Are you joking?  You don't have any code doing that today.  More feelings=
?

The 'no downside" is to combining two calls together; mmap() & mseal(),
at least that is how I read the linked discussion.

The common case (since there are no users today) of just calling
mmap()/munmap() will have the downside.

There will be a performance impact once you have can_modify_mm() doing
more than just returning true.  Certainly, the impact will be larger
in munmap where multiple VMAs may need to be checked (assuming that's
the plan?).

This will require a new and earlier walk of the vma tree while holding
the mmap_lock.  Since you are checking (potentially multiple) VMAs for
something, I don't think there is a way around holding the lock.

I'm not saying the cost will be large, but it will be a positive
non-zero number.

Thanks,
Liam

