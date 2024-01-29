Return-Path: <linux-kselftest+bounces-3703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CC28412AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 19:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98111C23953
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 18:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8731152DF7;
	Mon, 29 Jan 2024 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i27xHH+A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J53sOU/H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B368A1D687;
	Mon, 29 Jan 2024 18:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553773; cv=fail; b=ntWbBcNbtAcUqCxO9juDQcn4ZBarzcFX+8jjGg2ldhC5WbICAj3eQ2c3X2u8JAWdCpJ3JzLmDX+rIFN0n/yMIh5SbRyzisJYjnOJ4eGzhfEYg1YGS3X7CafvpuAdrC6jYR8qtZ5K6y5+gCEcVKNoaPMyDgPb94m+bRzw9F+HiEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553773; c=relaxed/simple;
	bh=HW9Dp+CdQIvH1S6zVVp/8uNsdTIk0KBmwY4nvMI889k=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RfZdkvQE53hP1dzu7gxY22Euy+LM204FF0sCqUAkXRqM1nqUCaMPCxBVHch31X0hRs91hfV4P2L2fpCNkCeDDoHgTUOk9PO6ymZQzyi7jMefe5xN5i4JrATIUnunnwUCf38iC/s2H4tN5Fl/JQlaSOSqeFuFIexvH38k+iX8eC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i27xHH+A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J53sOU/H; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TGmrPk023815;
	Mon, 29 Jan 2024 18:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=6Le7edgNrW+xqRxoACdWgC3V3dPKPO1PqKW/Oz7Gbhg=;
 b=i27xHH+ARTCnM+kXMUYV7xql6PqgV00VqtitiBdkiulTotSWmFqa0DigWsbfAIS3f/08
 fubwLPKGp17KZcEZ8t4hwO5nhcD4cDt6zmP7qAxghUOhdEKjIC4+3rTrH97F4WXpzu1a
 siNSaar67CDQs8NCTk8iqe2Zl62VrWWsFYJgb0+hdbz7fr11CGO/GLtM0AUX10IvHjlB
 CNWo1Cy60YQEXcHZLt62Wij2agcpcSbZenCZ44xINdwXE6fHg1Fj+9vZqj6F+M5k+13Q
 XkHNH2vNJGkUZN2jFGXRi1hyDm/7gdv8ZP+yBBjkkfNXUfxFTna1/8zgOaR1irkDcd7R bA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvsvdmp4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 18:42:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40THFq1o008488;
	Mon, 29 Jan 2024 18:42:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9chw7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 18:42:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJ4W0iHjnU2ZtEMckzbaEE2+OdUp7dj+lxJa4Dgk+ji5s/c8PkgLXIzzvtSuLeLiS/g+QU0hMeWzX4JnLK65/pG/z8KfSZQmFpPkNg6RekVzs91vXQl7Cm6WvxNJAQ0vrsi3lNnjIs4ygS+fm+7n5WZ0+vx9uVpddp9UHNeDtC56yeCEBbhW/KbdBCG/iTB95Jxh8hEJPQchOjuZft51fUA03MIgn16gSVLF6W4qLz1oJgZvRG13YoF9VBsaqg8ZRMS25F8oHJI4F8ZSV4ekxa+8Ba/p+lgcmmopHFiMPSkJYyu1CSG/RDXwEBLHjVHda2He+uQmoPHAnQnFaGRneg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Le7edgNrW+xqRxoACdWgC3V3dPKPO1PqKW/Oz7Gbhg=;
 b=QeOZZtAedqzTbA7zcIrLXCPRNLz889Zv74YIlY+P9ciYF5wl0IUoImXglBS7rkxaw7WzCVpPxTmZvwr4HDBfGcseWozW1Z9yovvFh6psMXJQDokAK09XMrAeG1Pnzrf3sANNNNt+/6p5ctpHhjLTR68pWJK58+xaMJRUeYQn8rfP5ahPdJPeQPAszBOwtowOOkaLzrMP9DIy0QVGc54w8PoSTqJEPrj+DEJRSUZTDDu5ienIy84zlmw3QvPYp0s4Bs0XDvstzmHr9ijTmCeunLMBUNIiF85PHn+X92+gcRf9cQle2paon66hitbshTBZ0sLKV/ACjyFtr1aCxBZPBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Le7edgNrW+xqRxoACdWgC3V3dPKPO1PqKW/Oz7Gbhg=;
 b=J53sOU/Hc4Bs9sJesuVfcPyUIaVsx6OeHji8tYyiGxwI6QaTtTOVnz8TWI615t+SQrTzsRWgQ5PAMdeaYrl5M7cg9A/fLSkcYw59SfJMggei46SsFMKE4CCUVzZZ2JdFfUjoVinNMv0kpVECdIXPlJxh+WalGkqYo2FsrP6RXJs=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by DS7PR10MB5021.namprd10.prod.outlook.com (2603:10b6:5:38f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 18:42:40 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::a1c5:b1ad:2955:e7a6]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::a1c5:b1ad:2955:e7a6%5]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 18:42:40 +0000
Message-ID: <8fad453a-09e4-a3ef-81d8-dd791d74a89d@oracle.com>
Date: Mon, 29 Jan 2024 10:42:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] KVM: selftests: add kvmclock drift test
From: Dongli Zhang <dongli.zhang@oracle.com>
To: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: pbonzini@redhat.com, shuah@kernel.org, seanjc@google.com,
        linux-kernel@vger.kernel.org, joe.jin@oracle.com
References: <20240106083346.29180-1-dongli.zhang@oracle.com>
Content-Language: en-US
In-Reply-To: <20240106083346.29180-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::33) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:EE_|DS7PR10MB5021:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e12f14-b102-4c31-fc57-08dc20fa121f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Xv25DBmKUD82oTvdVFDXYfT15Gq5T8PHbTehFnohRPXwEVKS7uupmM5pl8wh3EP7kxcUdQ41qJF7GLQPSMb1Ht7Istd2MMgDOBvXiGap3Y5uLpLu9FIQmYrWqcuhZbx0X2pwz7ngfd3hO2+TDG7dYHHyMEbn4k0ocE6++zpwcVsMdxRn2AnW0N3HdNPFvJUtlHXEURkWg0CahWvtxuvS8DJYz9Ref5fO2eOmrkqLxt0Y109m6YlqwenHkEGNaN3N8njQGLwHdkKiWmNTgX1nFPRJkuM//sDfzXaBOcUOlFKqzsdnjUcfScEtfF1Gs8Znsy+8Ghaukk8gWYzUBP+htghV/Di3+OUiVv/hmdBDgsR47bd/FUsPFBr0lhuii4DDbW3CuW98PxXK/jCbFeaIF9Siot6dbx6WrSaUG21O5wgIP2AEWB3N3S6afKu6v2PILN9MiqFRrTQUm5blIh9QehR+6Rq+xYPCh8x1Wiq0TwgsLRKMXrOfZWvtlql5n7gGgC9hE283emjrifvMEnkfMwEWBrgyej5Oj81MYMKq8MIRgE5B1URHy+z4THaXlyO93rzRG/UvwdbI76PfwEyunpfuPH4cgtxtYAEkEpa6/GhApvwkjsXcl1bej4ihhzEMpdttA44V8Tc2UA8ud9mV6A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(136003)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(26005)(53546011)(83380400001)(6666004)(107886003)(6506007)(36756003)(86362001)(2616005)(31696002)(5660300002)(41300700001)(8676002)(66476007)(4326008)(6512007)(38100700002)(66556008)(2906002)(44832011)(66946007)(6486002)(8936002)(966005)(478600001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NFFveEtJMnkrZ0grUk8rYzhuRkpBclRqTTN6L3Jjd0ZMd0RQaEhsclkxQVoy?=
 =?utf-8?B?Y0JwMjNwN2ZtZVpDd01Da29RQlg2TUlGNjhuV25lTG9TTXFlQkRMZlc4RU0r?=
 =?utf-8?B?TEZzSmlIcCtQeUFhWFZIdjd4WW1NZTlzcktXZ2tPYytNajVZTnIvV0QwbHFF?=
 =?utf-8?B?M2FOSlVaTVdMSnBLTFJOTnFKY3FsMVZ6WFQzZWIrelZHWWo1L3htcXowSVJt?=
 =?utf-8?B?UFJiWC9oVnVaUGVpTzBzQ0lObU1Ec0wrT1VHN0pUUXo0eHRWanBTcnJtZTdR?=
 =?utf-8?B?WmNqMUIvRGEyRUJ3OWsxald6ZEdOTUFKQTFxVmxtcThJbjJwV3FaUXhJcDZ0?=
 =?utf-8?B?UlNHMzFqSDFSdTFkVU80WXNSRDM1T204TUFjZldISUNyZFVtNnUrakV3OWoy?=
 =?utf-8?B?SjJCSnhQQzBydUlVNkxvSWpZMXY0YWU5R1FkYWQxK2pIK0lvZ24vbVZncU9G?=
 =?utf-8?B?RmZ6WjZTWWJUdzFnb3RDR0tMaGRRMWhTOEtvV3UvU3dEZUZVdkQ4bGozMWJm?=
 =?utf-8?B?OVBGTUxpSFZmelZ0SlM2VlF3dEZkUlduTlhMTVZnU29yWTUzMUxoekVjTlVo?=
 =?utf-8?B?K1F6bzBjcVNwOG1CaThTM0Y2bkVsbUxPZHNjRjV5czg4eUZaSmp0czB5MTk0?=
 =?utf-8?B?VlQvazRqK0NKWUwxZnNteExYeFo0R2Q0L0VOWS9RTjQvWm5veHRpNnVHOEdT?=
 =?utf-8?B?VFJISEZqTjByNmFmak1rWnhlY2QzVmtBQk4rQXVmbjVNRlZvRGdtaWZxSUZP?=
 =?utf-8?B?N2ZVd1MwRnRXSnRNdlByU1Fnem5XZFErREtBZTQyMVhwR3c0dm1NYVRjb2ph?=
 =?utf-8?B?a3k2UERJYTNxSS94MUF5Z1AwR3orT3pQZG92ZHNlNnZWSHpyTFhxYzVBdmNW?=
 =?utf-8?B?YjBCOWtBQ1lLKzFKNkthclpJMGpOM1NKTGFXcitEWGxwN0VhQzNWTkI1YlRu?=
 =?utf-8?B?MjhaY1JpQzNpeUNEMHBtMG16eXpmMnlFQUlMaUtna2s1M1ZJakxFVjB6dDQx?=
 =?utf-8?B?YmNLU0pPdG5MYWxzanBRVHlQYmRoSzNGc3JQR3JBeU1TcU5JRjduaE4xYmNK?=
 =?utf-8?B?VURFRm5kWjlCbTJSWUhyRmV0bHc4eDE2VkJuTG5xN2ltSHZrdmVjM1ZGRVZo?=
 =?utf-8?B?L2FRZytjV0Fla2kxdlRCRzM3ejgyVzQzcE0vTUduTjg5TzJITE45dU1yWXFw?=
 =?utf-8?B?SVJWc056UnFKN1YweEF3MXU2U0JHUjc1YW41U0xsRCtpeUVPR3ZTZU5lOFJY?=
 =?utf-8?B?Tm9McGEvMkpmUnJKeDYvbHkwVUZmazkxOVFEdjJ6RHB6MytLaDNDcWI3Y1Ra?=
 =?utf-8?B?MFFpcXFFZmsrWmJTWEtGQW9FRzh1TUdwaU1qcUFYS20vZmp0YWZlU2ZwYjZr?=
 =?utf-8?B?WE05WUFySnI3cFJ0Z0NSRE91QmNaQTdKVnFBUjBBdEtnSXdLOVVzQ2FTbFNL?=
 =?utf-8?B?Q1F5VktGRWV5M2FaMVpaeEllSmgybVJWRHkzdzJzT2ErOXJ1elRlL0pjRDUz?=
 =?utf-8?B?dXlUNTVQVEdLVHBqMTBqeWEvSGFPL3RiNG4wSm5oR2QxNDRWRHZlMnFPQ2RS?=
 =?utf-8?B?MlVHMjJvU29oUkVwVVgwczFrMlhpbmN1RlJFOUxDSjJ2YVRQSWc5Z2YyY2g2?=
 =?utf-8?B?a21mT3d2ZFlHM0pTajZOODlJdUREMXNLYjhVOFVlUHJmT1N3RFdERVViM29R?=
 =?utf-8?B?OWoxb05hSHhqbHF4UUNTeHY4eDVuZjBTNVhvbDhUTjVCVlNoTEx2dnJxdFVN?=
 =?utf-8?B?RmVHNGZZWmRES1ZqcXl2T0g5VEpKSUNXeXVUNHJzY1VFeXliNGtKN25ROWg5?=
 =?utf-8?B?UFN1MmtQbitLN3NUOXVqTmVqcVl2VUdGN3JDTHZSaC9KOHpjVmprSTk2aWpT?=
 =?utf-8?B?cDNLRWJ6cDFMVjlqQ21RMU11Unl4bUtLaUl6UU5sTTZxRXZKQ1VEbzd1ZWJr?=
 =?utf-8?B?VjNiNGRlTHdkSGpSS21zdTlobUlCalByKzBWNDJqR0F0WFF3aFIybThMdjR4?=
 =?utf-8?B?bDYvVnNJaTBqbHNkVnQrdkRDamFhZGc3UWNlc3c1bWduMDVKa2YvVndYTDlT?=
 =?utf-8?B?bFFLWmhsemtmRzVuWlJQLzRhWC9EcUw1amExSEdIRHhwRWJHNVFsWERuVmNE?=
 =?utf-8?Q?lFHTJiRAFVf4vG7NFDl3lk45v?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VPdiVBad+5M5drv9wgy1LDTSgvDfn89ET73Vw5HtcEHJPmWWSNu7RZlNpBT1ss/hrmGdUFLIItkdtkYFBZghvKsAKAdsD9tD/K/SWM9++etJLJz7kwd7KwqwrL9N7jcTMeDp8NubLEaOQDQmRXiO1hwF5aHO+Bp4j/LEcsVXBtBXktxajOy/TbddWNf4gik6R8wjH5VRI94skiB6KJ0KotdKGlSSb58OBox1NhgVlEyw938Ejn/FqPH2GsFN9Oc1fGGNbsnY1wYg5EImwyZPSf6J+MgEkNjK+PvATWd4QqlSzKYB+CDzaIMhmExGOvv/yw2BXN+AYoVjYi+ep1t/dr5Mq857IvmGNTDFF9wovqyNAK4Bc5N6VFmfl0gwwbWkEyBuVNb9KJ9+FsbP4gMi1cpJx8PEoDUFmyR3Dpvw464ZgnXEAK8tUbHzmlbYzDHwLHnvV+Cq0ss16JWrAOkCSHxevznWFPzNh2j4WMzZT/qF8LIg4OAOxKdFkV+GZQk69FL7yN5fC+91tH82ZquGe1FaIeA+mr938K8HJunNXZRlcZfXCeMG9/Vab3ExkAgBkb5u7RqEm/vkFdJDb5oR91FBthhN41X4ptI/49YzF6A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e12f14-b102-4c31-fc57-08dc20fa121f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 18:42:39.9103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijKLxuhv1HMWODzlWEXWifbuoJ38US9gdj9crH6agTqh7J1HXb5amdX2YlFc2o50/Lwm5/EP8Wjt3QYZyI2Ekw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5021
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_12,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290138
X-Proofpoint-ORIG-GUID: hvD1JKbskpbXILkrBr-f4hKYOWtp3tbu
X-Proofpoint-GUID: hvD1JKbskpbXILkrBr-f4hKYOWtp3tbu

Ping :)

BTW, I see Vitaly Kuznetsov has a patch to generalize check_clocksource(),
which is also used by this patch.

[PATCH 1/5] KVM: selftests: Generalize check_clocksource() from kvm_clock_test
https://lore.kernel.org/all/20240109141121.1619463-2-vkuznets@redhat.com/

Thank you very much!

Dongli Zhang

On 1/6/24 00:33, Dongli Zhang wrote:
> There is kvmclock drift issue during the vCPU hotplug. It has been fixed by
> the commit c52ffadc65e2 ("KVM: x86: Don't unnecessarily force masterclock
> update on vCPU hotplug").
> 
> This is to add the test to verify if the master clock is updated when we
> write 0 to MSR_IA32_TSC from the host side.
> 
> Here is the usage example on the KVM with the bugfix reverted.
> 
> $ ./kvm_clock_drift -v -p 5
> kvmclock based on old pvclock_vcpu_time_info: 5012221999
>   version:           2
>   tsc_timestamp:     3277968
>   system_time:       11849519
>   tsc_to_system_mul: 2152530255
>   tsc_shift:         0
>   flags:             1
> 
> kvmclock based on new pvclock_vcpu_time_info: 5012222411
>   version:           4
>   tsc_timestamp:     9980576184
>   system_time:       5012222411
>   tsc_to_system_mul: 2152530255
>   tsc_shift:         0
>   flags:             1
> 
> ==== Test Assertion Failure ====
>   x86_64/kvm_clock_drift.c:216: clock_old == clock_new
>   pid=14257 tid=14257 errno=4 - Interrupted system call
>      1	0x000000000040277b: main at kvm_clock_drift.c:216
>      2	0x00007f7766fa7e44: ?? ??:0
>      3	0x000000000040286d: _start at ??:?
>   kvmclock drift detected, old=5012221999, new=5012222411
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/x86_64/kvm_clock_drift.c    | 223 ++++++++++++++++++
>  2 files changed, 224 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/kvm_clock_drift.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 4412b42d95de..c665d0d8d348 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -84,6 +84,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/hyperv_features
>  TEST_GEN_PROGS_x86_64 += x86_64/hyperv_ipi
>  TEST_GEN_PROGS_x86_64 += x86_64/hyperv_svm_test
>  TEST_GEN_PROGS_x86_64 += x86_64/hyperv_tlb_flush
> +TEST_GEN_PROGS_x86_64 += x86_64/kvm_clock_drift
>  TEST_GEN_PROGS_x86_64 += x86_64/kvm_clock_test
>  TEST_GEN_PROGS_x86_64 += x86_64/kvm_pv_test
>  TEST_GEN_PROGS_x86_64 += x86_64/monitor_mwait_test
> diff --git a/tools/testing/selftests/kvm/x86_64/kvm_clock_drift.c b/tools/testing/selftests/kvm/x86_64/kvm_clock_drift.c
> new file mode 100644
> index 000000000000..324f0dbc5762
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/kvm_clock_drift.c
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * The kvmclock drift test. Emulate vCPU hotplug and online to verify if
> + * there is kvmclock drift.
> + *
> + * Adapted from steal_time.c
> + *
> + * Copyright (C) 2020, Red Hat, Inc.
> + * Copyright (C) 2024 Oracle and/or its affiliates.
> + */
> +
> +#include <asm/kvm_para.h>
> +#include <asm/pvclock.h>
> +#include <asm/pvclock-abi.h>
> +#include <sys/stat.h>
> +
> +#include "kvm_util.h"
> +#include "processor.h"
> +
> +#define NR_VCPUS		2
> +#define NR_SLOTS		2
> +#define KVMCLOCK_SIZE		sizeof(struct pvclock_vcpu_time_info)
> +/*
> + * KVMCLOCK_GPA is identity mapped
> + */
> +#define KVMCLOCK_GPA		(1 << 30)
> +
> +static uint64_t kvmclock_gpa = KVMCLOCK_GPA;
> +
> +static void guest_code(int cpu)
> +{
> +	struct pvclock_vcpu_time_info *kvmclock;
> +
> +	/*
> +	 * vCPU#0 is to detect the change of pvclock_vcpu_time_info
> +	 */
> +	if (cpu == 0) {
> +		GUEST_SYNC(0);
> +
> +		kvmclock = (struct pvclock_vcpu_time_info *) kvmclock_gpa;
> +		wrmsr(MSR_KVM_SYSTEM_TIME_NEW, kvmclock_gpa | KVM_MSR_ENABLED);
> +
> +		/*
> +		 * Backup the pvclock_vcpu_time_info before vCPU#1 hotplug
> +		 */
> +		kvmclock[1] = kvmclock[0];
> +
> +		GUEST_SYNC(2);
> +		/*
> +		 * Enter the guest to update pvclock_vcpu_time_info
> +		 */
> +		GUEST_SYNC(4);
> +	}
> +
> +	/*
> +	 * vCPU#1 is to emulate the vCPU hotplug
> +	 */
> +	if (cpu == 1) {
> +		GUEST_SYNC(1);
> +		/*
> +		 * This is after the host side MSR_IA32_TSC
> +		 */
> +		GUEST_SYNC(3);
> +	}
> +}
> +
> +static void run_vcpu(struct kvm_vcpu *vcpu)
> +{
> +	struct ucall uc;
> +
> +	vcpu_run(vcpu);
> +
> +	switch (get_ucall(vcpu, &uc)) {
> +	case UCALL_SYNC:
> +	case UCALL_DONE:
> +		break;
> +	case UCALL_ABORT:
> +		REPORT_GUEST_ASSERT(uc);
> +	default:
> +		TEST_ASSERT(false, "Unexpected exit: %s",
> +			    exit_reason_str(vcpu->run->exit_reason));
> +	}
> +}
> +
> +static void kvmclock_dump(struct pvclock_vcpu_time_info *kvmclock)
> +{
> +	pr_info("  version:           %u\n", kvmclock->version);
> +	pr_info("  tsc_timestamp:     %lu\n", kvmclock->tsc_timestamp);
> +	pr_info("  system_time:       %lu\n", kvmclock->system_time);
> +	pr_info("  tsc_to_system_mul: %u\n", kvmclock->tsc_to_system_mul);
> +	pr_info("  tsc_shift:         %d\n", kvmclock->tsc_shift);
> +	pr_info("  flags:             %u\n", kvmclock->flags);
> +	pr_info("\n");
> +}
> +
> +#define CLOCKSOURCE_PATH "/sys/devices/system/clocksource/clocksource0/current_clocksource"
> +
> +static void check_clocksource(void)
> +{
> +	char *clk_name;
> +	struct stat st;
> +	FILE *fp;
> +
> +	fp = fopen(CLOCKSOURCE_PATH, "r");
> +	if (!fp) {
> +		pr_info("failed to open clocksource file: %d; assuming TSC.\n",
> +			errno);
> +		return;
> +	}
> +
> +	if (fstat(fileno(fp), &st)) {
> +		pr_info("failed to stat clocksource file: %d; assuming TSC.\n",
> +			errno);
> +		goto out;
> +	}
> +
> +	clk_name = malloc(st.st_size);
> +	TEST_ASSERT(clk_name, "failed to allocate buffer to read file\n");
> +
> +	if (!fgets(clk_name, st.st_size, fp)) {
> +		pr_info("failed to read clocksource file: %d; assuming TSC.\n",
> +			ferror(fp));
> +		goto out;
> +	}
> +
> +	TEST_ASSERT(!strncmp(clk_name, "tsc\n", st.st_size),
> +		    "clocksource not supported: %s", clk_name);
> +out:
> +	fclose(fp);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct pvclock_vcpu_time_info *kvmclock;
> +	struct kvm_vcpu *vcpus[NR_VCPUS];
> +	uint64_t clock_old, clock_new;
> +	bool verbose = false;
> +	unsigned int gpages;
> +	struct kvm_vm *vm;
> +	int period = 2;
> +	uint64_t tsc;
> +	int opt;
> +
> +	check_clocksource();
> +
> +	while ((opt = getopt(argc, argv, "p:vh")) != -1) {
> +		switch (opt) {
> +		case 'p':
> +			period = atoi_positive("The period (seconds) between vCPU hotplug",
> +					       optarg);
> +			break;
> +		case 'v':
> +			verbose = true;
> +			break;
> +		case 'h':
> +		default:
> +			pr_info("usage: %s [-p period (seconds)] [-v]\n", argv[0]);
> +			exit(1);
> +		}
> +	}
> +
> +	vm = vm_create_with_vcpus(NR_VCPUS, guest_code, vcpus);
> +	gpages = vm_calc_num_guest_pages(VM_MODE_DEFAULT,
> +					 KVMCLOCK_SIZE * NR_SLOTS);
> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
> +				    KVMCLOCK_GPA, 1, gpages, 0);
> +	virt_map(vm, KVMCLOCK_GPA, KVMCLOCK_GPA, gpages);
> +
> +	vcpu_args_set(vcpus[0], 1, 0);
> +	vcpu_args_set(vcpus[1], 1, 1);
> +
> +	/*
> +	 * Run vCPU#0 and vCPU#1 to update both pvclock_vcpu_time_info and
> +	 * master clock
> +	 */
> +	run_vcpu(vcpus[0]);
> +	run_vcpu(vcpus[1]);
> +
> +	/*
> +	 * Run vCPU#0 to backup the current pvclock_vcpu_time_info
> +	 */
> +	run_vcpu(vcpus[0]);
> +
> +	sleep(period);
> +
> +	/*
> +	 * Emulate the hotplug of vCPU#1
> +	 */
> +	vcpu_set_msr(vcpus[1], MSR_IA32_TSC, 0);
> +
> +	/*
> +	 * Emulate the online of vCPU#1
> +	 */
> +	run_vcpu(vcpus[1]);
> +
> +	/*
> +	 * Run vCPU#0 to backup the new pvclock_vcpu_time_info to detect
> +	 * if there is any change or kvmclock drift
> +	 */
> +	run_vcpu(vcpus[0]);
> +
> +	kvmclock = addr_gva2hva(vm, kvmclock_gpa);
> +	tsc = kvmclock[0].tsc_timestamp;
> +	clock_old = __pvclock_read_cycles(&kvmclock[1], tsc);
> +	clock_new = __pvclock_read_cycles(&kvmclock[0], tsc);
> +
> +	if (verbose) {
> +		pr_info("kvmclock based on old pvclock_vcpu_time_info: %lu\n",
> +			clock_old);
> +		kvmclock_dump(&kvmclock[1]);
> +		pr_info("kvmclock based on new pvclock_vcpu_time_info: %lu\n",
> +			clock_new);
> +		kvmclock_dump(&kvmclock[0]);
> +	}
> +
> +	TEST_ASSERT(clock_old == clock_new,
> +		    "kvmclock drift detected, old=%lu, new=%lu",
> +		    clock_old, clock_new);
> +
> +	kvm_vm_free(vm);
> +
> +	return 0;
> +}
> 
> base-commit: f2a3fb7234e52f72ff4a38364dbf639cf4c7d6c6

