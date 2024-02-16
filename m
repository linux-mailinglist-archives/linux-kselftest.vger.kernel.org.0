Return-Path: <linux-kselftest+bounces-4877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07020858610
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 20:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C909B2252B
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 19:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CD4135A6C;
	Fri, 16 Feb 2024 19:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NGPilcf4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q4TcvQbE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C54135A73;
	Fri, 16 Feb 2024 19:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708111116; cv=fail; b=fzgFwXFf/e90/l8kop9ru9/z0nT/SC4ZPLCoCOlolYuJzVPKIcyGrNcUIsKejAINCKts0PbUKKnOS8bkOK90nq73E7G18qnSJiDpJCsRqdAmcC2f/OCl++NiWMiDPoJ0bz/BODemAgH0F/42q5rtOTy25r7vxBVo8rATwp1nQKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708111116; c=relaxed/simple;
	bh=niZSrJ6Z7vlGWl8RTOlveAFwl8uOjRYkVPVoaCg9BUQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KxmzzR3vnk1kYW2XvyjHAxKTkwOA7jS676cq8ELpyOYbzKliUJA8CAuuw9CH27WNG/LjnMaCw9MmvH8HlYEPBJX7VQDTOZepKY3pDHTnaQLIV3PUO+VjhhjtqP6x06Q9YWWWr2VPH/f7TrRqo4Mdw7uTP/I4pnX2OY895r9+jpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NGPilcf4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q4TcvQbE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GCrosb003318;
	Fri, 16 Feb 2024 19:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=EcMNXLUTxHoBYO2xsrdi+eWs1LXJtSgS9pFXm2luyQU=;
 b=NGPilcf4KTYV/1YkDnSy3NeGtPbEXHno3RltHbz+S5GIKdXoH7XMTBfB/WnWHCTtcLHc
 2jLw9V2wv06yMLPbFOA1xYkp6wQgNiAMplOtGbukY4KAQH5FOAwLYZSzUkJVw/Mk2y1a
 Q+w2BZnpcITRPT0b/7hkn407vjNU2x224yWuMHa2vp7aTdrAIAPB+dpdxjV5o7zmH8bu
 m3NiR7m9jnCWJBpP1WoU1SZ5XPiwbU/0URpw4048mJuEfC6p13pmie4QQ218h+iz3wb5
 mINyzuQVN1rM4yAwPpokExhBBWKAAw3xKADO1lITSuJVf7FdlkniE3xrT6Rn7OUuu9L0 Qg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92j0ny87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 19:18:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41GHnAIn000682;
	Fri, 16 Feb 2024 19:18:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykcm86x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 19:18:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOcaG0FFMeyPdsvjLe8hEw9toPIUrDSA5uRO7wPPKSHZ/D8ZjlvUV2swzTtJjkEgtf4Ez0SeTekX2orMkjmiDYjaEiqtPQLGEcsZxxpoQazT2U2ZHNMd4gphifUsGGRn6lBVGQPmLKseuNkKPWgbMqivbRYTvz6zUDZBgVd7NKNc73nNlKjvvcBBxDNjB/YnJYa+0dXKgCBZTXm04QbOJkQwlaZYd0EK4x0QjXDyhjKrZdhaDXVvbCLjFMm7W1PCkB6M7H/q0Tfy2/QTAn07AYzV5bV6cCRIwUxOP2u5zh8AWVWohj07nUVPIs4lN28bwFcIT8gR+oN/l1hmA5KvwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcMNXLUTxHoBYO2xsrdi+eWs1LXJtSgS9pFXm2luyQU=;
 b=GUM0X+EfM35ZRAaSDwqFrJuKuTZ6a0LFeoFPreQoVXueWftE3ULky1aDhd+1476sGtHp+IfbuvVVWtunQ6BwaEaxmhe2kydaLuliYS30LhlNJDQKKnK4kfU7HcSfLUTeANw+aPKTZ5iAQsVbFhMUIjGNZ5Sre0CGrJ3a9iS8aXV/duF38yBf/vOQrNXc3IVT97Q0+bm/40ZBapN8zejteJ3Y4aw0x7Idwo1upwvWU44IA+q2AYL07Cm26Udq4AZqCPxugy9jo2552/uq+qkUZqaGuHI7qKL+smm+WZOVPo1fSkRSTh7eFz0/PvdUqQagQgIUHGmncnjRnTlpqu7AUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcMNXLUTxHoBYO2xsrdi+eWs1LXJtSgS9pFXm2luyQU=;
 b=q4TcvQbEKw3RremUve0oNUxcEqkAfHNYELT5iz6TPMHkZ5tUV+uIGqXoXWaxMp8Za+Cice8fnqipKwMaKaKvV/uVl+v6jlTPol5WD/iRRMZM6/T4gAI08yproiWVhE9RDC89ha68EM/PcY1petnR7HouN+uxr2NIlCk91tA8b3w=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by DS7PR10MB4943.namprd10.prod.outlook.com (2603:10b6:5:3ac::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 19:18:09 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::b79c:372d:3ec2:e2a4]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::b79c:372d:3ec2:e2a4%7]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 19:18:09 +0000
Message-ID: <91a5dd24-3a91-3114-d73d-eb57f3128d2e@oracle.com>
Date: Fri, 16 Feb 2024 14:18:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] selftests/sched: Migrate cs_prctl_test to
 kselfttest
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc: Suleiman Souhlal <suleiman@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Steven Rostedt
 <rostedt@goodmis.org>,
        David Vernet <void@manifault.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney"
 <paulmck@kernel.org>,
        joseph.salisbury@canonical.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>,
        linux-kselftest@vger.kernel.org
References: <20240216183108.1564958-1-joel@joelfernandes.org>
 <20240216183108.1564958-9-joel@joelfernandes.org>
Content-Language: en-US
From: Chris Hyser <chris.hyser@oracle.com>
In-Reply-To: <20240216183108.1564958-9-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0066.namprd20.prod.outlook.com
 (2603:10b6:208:235::35) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|DS7PR10MB4943:EE_
X-MS-Office365-Filtering-Correlation-Id: 4325d7bd-49cd-4be9-eb2b-08dc2f24030e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sIRw7ic7ot5ytf31S3EuwdKnPMWhbdfWI4Se7FPzoEMGULwCfY2UD3g2hgKhQWZ++hDEmE3GbeQ4B4QxQMnlrcemmA5krbv57mtgN2YuOW6N+sNQ/TMrbnHtk+tLu2r+dEOlVR0cALI3MEECTw/jx6sd9QgwZMEGGghjVqjvCCVKrQvdrKxoFm5evi8BzCi88iYy/r3gaiTSOYOithZFwgIa6ajPW+9b2wA+u7R2zBox6wjkgX1PD7ExcCFbsyLOI8PExeXNwEO/g57Mq+iaygHuDmBmt0pBuE+vzRKMHjTt2QqgFhNsSf6mDnjCM4J2Pl5SwUri7QJqEgTT5dj/6FZ4nNiWMsBrWEm1e/gTlXtBH23PVZeS8obpOYdakLNCwPLtnTHjFYc4F+70s6i30yOXnx9Z0tpdyn0d3XMfsdZWaHX6D6Y98lObKZsBl3Np1RIoIxISW4y+UHKmqPaW/qBM3HB6BV78FSxuISEtCbXMYqSqvSr3VUGdF1OmOayHNE9NMNzMe4BRAhn2ybzrG+LXB8KQ8bnwysj/vVOnr0sMQdrdG05hgdoeKSukTPFG
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(376002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(86362001)(31686004)(4326008)(31696002)(38100700002)(83380400001)(26005)(2616005)(316002)(41300700001)(44832011)(2906002)(5660300002)(8676002)(66476007)(66946007)(66556008)(8936002)(36756003)(6486002)(7416002)(6666004)(478600001)(53546011)(54906003)(110136005)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OGtoV3hQbEtJYmpJK090SklpQVlMTnFHKzByQXZ0VFhxaDU3OFUxVzg5bHlw?=
 =?utf-8?B?cWxUQ0FOTDh6TWpFMjJkM0VmZjRvcWZQenlFRHBHMHBaYnpMRmxvNmkzMHJ3?=
 =?utf-8?B?Vno3NmlrYnk0azRzYTdHM0hLYXhlRUNXWXlpbkxQNUx1eTQ1OGVSc1I4d2Qr?=
 =?utf-8?B?WW5PbS9hSEdPUGZEc0gyOWRkNW9DV2xWSmFFREJsT1FPUyttNy9rNktpZmFj?=
 =?utf-8?B?RGFGeEdwK3BYaHI3SEZRYkhGc3JkcDhKMElDS2tITkwrcW9EMVIzY3pqNVg5?=
 =?utf-8?B?dmlyNVJrTzFzRkFaSkZ2MUdPSXJPeVMvdDlReWVyb0pDNlhsUlNDb29EbitD?=
 =?utf-8?B?NTBCWElsaE90K0dwcnBXS0xiRnpzME14cVJNUWQ5TmZmNktFNk9TTUpMMTBO?=
 =?utf-8?B?VHdGbWFkdmJrRCthcll6OEtTZDlrWEdjcTdONkpMRGE5S3NRSkdqYjU5UkpF?=
 =?utf-8?B?bk9rQk1KWDZkTmlPQnUvMENHbzkzdHM5Y0tBS3orZlFzVkdnREJQZFpyc1l4?=
 =?utf-8?B?Q09LdmRRTGpBUlg5ekgxVzNDUVdOTDZSNUpGc1NQSTRMSlFodTNZNjhCS2JQ?=
 =?utf-8?B?c0JVai9sOEhBYS90aXBrYXo4QkIvT3R5eDloSE1LbzJ2NkJjbDVITExCT0ZP?=
 =?utf-8?B?ZFpuWVNCbFhtaXpmamY2b2lBeW1WWkFldXBKS3F3RFUrenRkcEV3WVhlRU9W?=
 =?utf-8?B?eU84azZ3WnMvcnM5VEhaRExPaU1hZkJJUHZaMFp6NGdOeDdsdU91d2VYaEtL?=
 =?utf-8?B?cytPV2xMQjJ6d3hyNlloTzhnZ1hSRDdKS0lUckFCajErSnN1VXVVa2poY0pk?=
 =?utf-8?B?OWUxa3VKY2ladzkzZldaZHkyck5CdElreTNSNlRjeWdFMzRBelRXRG9vS1F3?=
 =?utf-8?B?UjdZWUNBNGdvL3ZMbHFqVDZldXBLQktLcm5XSG91Tmh0N25JNzRuNm1SVTVB?=
 =?utf-8?B?dmxjaElCWHFpalkydFBHemdsVGZ4NEY4RVArVmFQYzloTnlhakM3WGx0eStT?=
 =?utf-8?B?eHU3OElwT2d3TG5wd0ZnNndBOVpkVVdsT29JYnliam9RbjEyYWV1L1U4Mmxp?=
 =?utf-8?B?b05kRUVjbndQVGhkQ1pGZmgwYmtBUTRURHRWUGQ3UDdxUEM4aG9MNzA1MC9x?=
 =?utf-8?B?V3VLbnN1cXI0N3RsTkd6TFpKSGFUUHJiWlhieDJYQnYzWEJKSnM5VFdNb3BI?=
 =?utf-8?B?NmlSZnE4Ui9OaG9NQ2xqU0gzeUJzZVNHSU5tYmU4YjR0SkZMc1pzeURueGxk?=
 =?utf-8?B?cHF2UElaOE9iTjFra2hVOTVzZC9OdWdDUDk3Tm1rQy8rUWdxeXE5UWdVNUgy?=
 =?utf-8?B?SnRQOS9qKzhQSkFqUkNSbHhFd1YvdXI5UkN6c2pLZVFZckdvMklsb0NXUTFr?=
 =?utf-8?B?aElHMEJSU2w1aHZBbDg2b0FEMlFuRGtKVFd0YVBZRGZrQzBVV3hCUGw2VnFu?=
 =?utf-8?B?OGtwZlhKcTlrbHl0MFFIeEpWV3h3UE8zc2dhbmRZd2lyVWdReVpBQlBuVjRI?=
 =?utf-8?B?NUZUVE4rWVBTbkU2N25lbVBabmVtQnoySkZEa0xPaGpBQWZlRFhldFNqdHJ6?=
 =?utf-8?B?dWUvMU0xbnovMEFsVGpzUGpKV2lHckxHWlk4L29TTU1iL0NjbXZwRnJXK2Qz?=
 =?utf-8?B?TEZMa2xKQUFxYmYzbkJjc0pzR1NyRm15YkJtSy9BZkoxWVdQTG9iejVKNmJt?=
 =?utf-8?B?eDRqbDJpbDdsNGRNVklzcmg2OXFwQnVuTm9HczdDZ0JFUWc3OTVzYldXWXNL?=
 =?utf-8?B?SmE1OGNCUTkyRE82UmErRkh5T2c3M0lhKzZkQ3hNdnJ2b2tDcWZUQ3Fod2sz?=
 =?utf-8?B?bUY5MU5JUDZydHRnSDdJQjRIaWl5K1ZtRkk4NTk1RWF3bEYyOGVpTldNaldw?=
 =?utf-8?B?c3VXWllFSitLbWtXWXlqVnVDWkV2dGphMnRXRlh3d3dmYm9laXZ0WjlYakta?=
 =?utf-8?B?V0R6T0pTZmlqWUJDQzBTYm92R1pJRWdJMnIzcWxmUkxWLzJDalBmbUc3UHBZ?=
 =?utf-8?B?NTd0Q3B0dWl6T1Ryem5UT0dlZEd5UlNBYlFwR2N1U1UyVExHUC9VdDdMMXRZ?=
 =?utf-8?B?UXZFdlZocmdySWd3ZlpLeU8vK2VrS0k0OHJDUUdYTG56OVRKWWJKK2JpRDZW?=
 =?utf-8?B?Q0crZmJGd3FSYWFWWUlKMHVGa2V0Yk5DbEorcnA0THdQTzJiQUw3SHY0elNy?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hPYPBOeLTeK58EMsId2TcGqAsDtKw6wc+v9ocsCUL7aH3oyTakGLfxp928dFXdQEoPIt/j/nUBx6ZvWF4ytS92JjrKRp9Q2+kLHgP3UKG/V5dcf199nmQ23+eyq7t+Tq7qyZKbUCZz5dsUxVVVY/JmwgG0ARCGCMDZ+do1hfYNgMOU2q3Yf8M6ZFXJUi7Qq5ov+iOE04K6e11En6/yPs7EZ8VIVRlzLpLBydeurNU9vBvmT85pXtVF9UXKM23WGhtEMy2D8R/7fZhHuHd5R0EtdSPXbxPmg9Zz5FC65V+51RgbSFF7fJVqJTHJAdUrU5YX2xScfB6UlVl9W8t6b3oyL+/6Gt1g/DEZKowSwQjb/26UqCkcNLcdCJWb/bzAI8xb1hW1f8Y3CUnFlajtFPFlOj3Ns9lr6fkU9V4XZ3qzCxg7QsfhLunzqqyPo9mS/2MbMS6MO1PaIWT0GTcWS1kz9ZDseE5tuNkLJZ+K4AvxH7LNtGDyam8ydyu8z3K7wZ+8iv35upa9fR0QznbqOJgWrNw1k3Uzsp2ongRpUZ2CkC5JDKxtdhggymjSLh3X/Vu2HKd0TCS3Q+7rq4QGKitWLqAa2kwj++l4NTLjWImOc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4325d7bd-49cd-4be9-eb2b-08dc2f24030e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 19:18:09.7528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNy1vdGcojUjMHRg3IB76UWNmBzpkH1a/RnsdZLWlZjD3xxPH3lnWEMprl+Gg/B5K/Tg/etkuTxszK9eg9QzAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4943
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_18,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402160150
X-Proofpoint-GUID: wKvuwGITTH6KoSpah3hDzng-TsDNWV-G
X-Proofpoint-ORIG-GUID: wKvuwGITTH6KoSpah3hDzng-TsDNWV-G

On 2/16/24 13:31, Joel Fernandes (Google) wrote:

> This test begs to be a kselftest, is in the kselftest hierarchy and does
> not even use a single kselftest API. Convert it.
>
> It simplifies some of the code and the output also looks much nicer now:
>
>   Totals: pass:17 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Reviewed-by: Chris Hyser <chris.hyser@oracle.com>


> ---
>   tools/testing/selftests/sched/Makefile        |  6 +-
>   tools/testing/selftests/sched/cs_prctl_test.c | 74 ++++++++++---------
>   2 files changed, 43 insertions(+), 37 deletions(-)
>
> diff --git a/tools/testing/selftests/sched/Makefile b/tools/testing/selftests/sched/Makefile
> index f491d741cb45..90c53bc1337e 100644
> --- a/tools/testing/selftests/sched/Makefile
> +++ b/tools/testing/selftests/sched/Makefile
> @@ -1,9 +1,11 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   TEST_GEN_PROGS := cs_dlserver_test
> -
> -cs_dlserver_test: cs_dlserver_test.c common.c
> +TEST_GEN_PROGS += cs_prctl_test
>   
>   CFLAGS += $(KHDR_INCLUDES)
>   CFLAGS += -Wall
>   
>   include ../lib.mk
> +
> +$(OUTPUT)/cs_dlserver_test: cs_dlserver_test.c common.c
> +$(OUTPUT)/cs_prctl_test: cs_prctl_test.c common.c
> diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
> index 7ba057154343..bb7aee703cdf 100644
> --- a/tools/testing/selftests/sched/cs_prctl_test.c
> +++ b/tools/testing/selftests/sched/cs_prctl_test.c
> @@ -28,10 +28,11 @@
>   #include <unistd.h>
>   #include <time.h>
>   #include <errno.h>
> -#include <stdio.h>
>   #include <stdlib.h>
>   #include <string.h>
>   
> +#include "common.h"
> +
>   #if __GLIBC_PREREQ(2, 30) == 0
>   #include <sys/syscall.h>
>   static pid_t gettid(void)
> @@ -80,7 +81,7 @@ static int _prctl(int option, unsigned long arg2, unsigned long arg3, unsigned l
>   	int res;
>   
>   	res = prctl(option, arg2, arg3, arg4, arg5);
> -	printf("%d = prctl(%d, %ld, %ld, %ld, %lx)\n", res, option, (long)arg2, (long)arg3,
> +	ksft_print_msg("%d = prctl(%d, %ld, %ld, %ld, %lx)\n", res, option, (long)arg2, (long)arg3,
>   	       (long)arg4, arg5);
>   	return res;
>   }
> @@ -91,21 +92,20 @@ static int _prctl(int option, unsigned long arg2, unsigned long arg3, unsigned l
>   static void __handle_error(char *fn, int ln, char *msg)
>   {
>   	int pidx;
> -	printf("(%s:%d) - ", fn, ln);
> +	ksft_print_msg("(%s:%d) - ", fn, ln);
>   	perror(msg);
>   	if (need_cleanup) {
>   		for (pidx = 0; pidx < num_processes; ++pidx)
>   			kill(procs[pidx].cpid, 15);
>   		need_cleanup = 0;
>   	}
> -	exit(EXIT_FAILURE);
> +	ksft_exit_fail();
>   }
>   
>   static void handle_usage(int rc, char *msg)
>   {
> -	puts(USAGE);
> -	puts(msg);
> -	putchar('\n');
> +	ksft_print_msg("%s\n", USAGE);
> +	ksft_print_msg("%s\n\n", msg);
>   	exit(rc);
>   }
>   
> @@ -117,7 +117,7 @@ static unsigned long get_cs_cookie(int pid)
>   	ret = prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, pid, PIDTYPE_PID,
>   		    (unsigned long)&cookie);
>   	if (ret) {
> -		printf("Not a core sched system\n");
> +		ksft_print_msg("Not a core sched system\n");
>   		return -1UL;
>   	}
>   
> @@ -160,7 +160,7 @@ static int child_func_process(void *arg)
>   
>   	ret = write(ca->pfd[1], &ca->thr_tids, sizeof(int) * ca->num_threads);
>   	if (ret == -1)
> -		printf("write failed on pfd[%d] - error (%s)\n",
> +		ksft_print_msg("write failed on pfd[%d] - error (%s)\n",
>   			ca->pfd[1], strerror(errno));
>   
>   	close(ca->pfd[1]);
> @@ -192,7 +192,7 @@ void create_processes(int num_processes, int num_threads, struct child_args proc
>   	for (i = 0; i < num_processes; ++i) {
>   		ret = read(proc[i].pfd[0], &proc[i].thr_tids, sizeof(int) * proc[i].num_threads);
>   		if (ret == -1)
> -			printf("read failed on proc[%d].pfd[0] error (%s)\n",
> +			ksft_print_msg("read failed on proc[%d].pfd[0] error (%s)\n",
>   				i, strerror(errno));
>   		close(proc[i].pfd[0]);
>   	}
> @@ -202,30 +202,29 @@ void disp_processes(int num_processes, struct child_args proc[])
>   {
>   	int i, j;
>   
> -	printf("tid=%d, / tgid=%d / pgid=%d: %lx\n", gettid(), getpid(), getpgid(0),
> +	ksft_print_msg("tid=%d, / tgid=%d / pgid=%d: %lx\n", gettid(), getpid(), getpgid(0),
>   	       get_cs_cookie(getpid()));
>   
>   	for (i = 0; i < num_processes; ++i) {
> -		printf("    tid=%d, / tgid=%d / pgid=%d: %lx\n", proc[i].cpid, proc[i].cpid,
> +		ksft_print_msg("    tid=%d, / tgid=%d / pgid=%d: %lx\n", proc[i].cpid, proc[i].cpid,
>   		       getpgid(proc[i].cpid), get_cs_cookie(proc[i].cpid));
>   		for (j = 0; j < proc[i].num_threads; ++j) {
> -			printf("        tid=%d, / tgid=%d / pgid=%d: %lx\n", proc[i].thr_tids[j],
> +			ksft_print_msg("        tid=%d, / tgid=%d / pgid=%d: %lx\n", proc[i].thr_tids[j],
>   			       proc[i].cpid, getpgid(0), get_cs_cookie(proc[i].thr_tids[j]));
>   		}
>   	}
>   	puts("\n");
>   }
>   
> -static int errors;
> -
>   #define validate(v) _validate(__LINE__, v, #v)
>   void _validate(int line, int val, char *msg)
>   {
>   	if (!val) {
> -		++errors;
> -		printf("(%d) FAILED: %s\n", line, msg);
> +		ksft_print_msg("(%d) FAILED: %s\n", line, msg);
> +		ksft_inc_fail_cnt();
>   	} else {
> -		printf("(%d) PASSED: %s\n", line, msg);
> +		ksft_print_msg("(%d) PASSED: %s\n", line, msg);
> +		ksft_inc_pass_cnt();
>   	}
>   }
>   
> @@ -254,13 +253,17 @@ int main(int argc, char *argv[])
>   			keypress = 1;
>   			break;
>   		case 'h':
> -			printf(USAGE);
> +			ksft_print_msg(USAGE);
>   			exit(EXIT_SUCCESS);
>   		default:
>   			handle_usage(20, "unknown option");
>   		}
>   	}
>   
> +	if (!hyperthreading_enabled()) {
> +		ksft_exit_skip("This test requires hyperthreading to be enabled\n");
> +	}
> +
>   	if (num_processes < 1 || num_processes > MAX_PROCESSES)
>   		handle_usage(1, "Bad processes value");
>   
> @@ -272,17 +275,22 @@ int main(int argc, char *argv[])
>   
>   	srand(time(NULL));
>   
> -	/* put into separate process group */
> +	/* Put into separate process group */
>   	if (setpgid(0, 0) != 0)
>   		handle_error("process group");
>   
> -	printf("\n## Create a thread/process/process group hiearchy\n");
> +	ksft_print_header();
> +
> +	/* Increase the count if adding more validate() statements. */
> +	ksft_set_plan(17);
> +
> +	ksft_print_msg("\n## Create a thread/process/process group hiearchy\n");
>   	create_processes(num_processes, num_threads, procs);
>   	need_cleanup = 1;
>   	disp_processes(num_processes, procs);
>   	validate(get_cs_cookie(0) == 0);
>   
> -	printf("\n## Set a cookie on entire process group\n");
> +	ksft_print_msg("\n## Set a cookie on entire process group\n");
>   	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, 0, PIDTYPE_PGID, 0) < 0)
>   		handle_error("core_sched create failed -- PGID");
>   	disp_processes(num_processes, procs);
> @@ -296,7 +304,7 @@ int main(int argc, char *argv[])
>   	validate(get_cs_cookie(0) == get_cs_cookie(pid));
>   	validate(get_cs_cookie(0) == get_cs_cookie(procs[pidx].thr_tids[0]));
>   
> -	printf("\n## Set a new cookie on entire process/TGID [%d]\n", pid);
> +	ksft_print_msg("\n## Set a new cookie on entire process/TGID [%d]\n", pid);
>   	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, pid, PIDTYPE_TGID, 0) < 0)
>   		handle_error("core_sched create failed -- TGID");
>   	disp_processes(num_processes, procs);
> @@ -305,7 +313,7 @@ int main(int argc, char *argv[])
>   	validate(get_cs_cookie(pid) != 0);
>   	validate(get_cs_cookie(pid) == get_cs_cookie(procs[pidx].thr_tids[0]));
>   
> -	printf("\n## Copy the cookie of current/PGID[%d], to pid [%d] as PIDTYPE_PID\n",
> +	ksft_print_msg("\n## Copy the cookie of current/PGID[%d], to pid [%d] as PIDTYPE_PID\n",
>   	       getpid(), pid);
>   	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, pid, PIDTYPE_PID, 0) < 0)
>   		handle_error("core_sched share to itself failed -- PID");
> @@ -315,7 +323,7 @@ int main(int argc, char *argv[])
>   	validate(get_cs_cookie(pid) != 0);
>   	validate(get_cs_cookie(pid) != get_cs_cookie(procs[pidx].thr_tids[0]));
>   
> -	printf("\n## Copy cookie from a thread [%d] to current/PGID [%d] as PIDTYPE_PID\n",
> +	ksft_print_msg("\n## Copy cookie from a thread [%d] to current/PGID [%d] as PIDTYPE_PID\n",
>   	       procs[pidx].thr_tids[0], getpid());
>   	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_FROM, procs[pidx].thr_tids[0],
>   		   PIDTYPE_PID, 0) < 0)
> @@ -325,7 +333,7 @@ int main(int argc, char *argv[])
>   	validate(get_cs_cookie(0) == get_cs_cookie(procs[pidx].thr_tids[0]));
>   	validate(get_cs_cookie(pid) != get_cs_cookie(procs[pidx].thr_tids[0]));
>   
> -	printf("\n## Copy cookie from current [%d] to current as pidtype PGID\n", getpid());
> +	ksft_print_msg("\n## Copy cookie from current [%d] to current as pidtype PGID\n", getpid());
>   	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, 0, PIDTYPE_PGID, 0) < 0)
>   		handle_error("core_sched share to self failed -- PGID");
>   	disp_processes(num_processes, procs);
> @@ -340,20 +348,16 @@ int main(int argc, char *argv[])
>   	validate(_prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, 0, PIDTYPE_PGID, 1) < 0
>   		&& errno == EINVAL);
>   
> -	if (errors) {
> -		printf("TESTS FAILED. errors: %d\n", errors);
> -		res = 10;
> -	} else {
> -		printf("SUCCESS !!!\n");
> -	}
> -
> -	if (keypress)
> +	if (keypress) {
> +		ksft_print_msg("Waiting for keypress to exit\n");
>   		getchar();
> -	else
> +	} else {
>   		sleep(delay);
> +	}
>   
>   	for (pidx = 0; pidx < num_processes; ++pidx)
>   		kill(procs[pidx].cpid, 15);
>   
> +	ksft_finished();
>   	return res;
>   }

