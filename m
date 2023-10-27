Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3F57DA3EA
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Oct 2023 01:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjJ0XBm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 19:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0XBl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 19:01:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34C3E1;
        Fri, 27 Oct 2023 16:01:36 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RLnDul026222;
        Fri, 27 Oct 2023 23:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : cc : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=BtYbm5Lx94XLVnNE7P2S8i41RzBoDv7FKFUSaTc0yuw=;
 b=4XRDe05P7R4asrqkawQC1ANiYgBWSLsQnCC8Ec16fTVJQSxHb2lCHXZvHHr93Tr1idhK
 cU8S1OdJwNXm9lOz2McptPoKnwD7gn6y5aEJz6hv0zPyx/vKLqGAw9r6Q8EOiw3G7edW
 ZCCd80Qh/aPcDj89lpWQQYlEmCWeSkBThfUSyCYUm3O3VuQjHfX+eWNtgnKndWODR8fd
 xlKWMPoBQtw/Pz40TmRI9hgRtioaM27EmG89wzCsg7043O4avrqqeviBt1EKcdb1fgZB
 Ce3Od0uU4WKVB1Kbhh6Xnkhk+tAgg2m6mh8FTbNaus9CW1V4EWsBcPrpOWXVrE2XVmqI Wg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tywtt2juw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 23:01:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39RLPVJ7008219;
        Fri, 27 Oct 2023 23:01:14 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqk5gre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 23:01:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jasnLJA1H4kcC7bpEDVpX2xTgMKmobLdeQVQTDg93jg35XFr0qqCXEYZbC9k/YVvKFqtPBzp05Iyw6F1bs2z36vf37LIhpKgNi24MlwpyQGhgXmycoyQzN2GexTlcUCU4f+mDzkCRvOebPy8mpusS3jmEiBUhuC0Jiul1TFRtaA9h+ypKjLToOdcKVVD4AwVtK9m3zEFJgVNt0wHF1FUmp2vqNBqnwVzy38Q1zmmWOwmObUneEgqFk7wFyWmt1+DHkQ1sY2zRVlGLD+Okztk1TOsRCkacOLX3cJN/VRWbmX/baFRumdkXkH7oAtAyy2sw93uw7gSoWCm+i/sZLvx+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtYbm5Lx94XLVnNE7P2S8i41RzBoDv7FKFUSaTc0yuw=;
 b=bfQvA6RupkU5dPGFUAoohMEC3khUMquXsbtf6BGM8AU6J+sgYVgDJNTSXbz6mqfvXnUMBABVFbdi3duyU4iRKKAu06YZ093/w1JY7msFQH2ZAnj7GGICp/guOgq3lRkQ79sPzxgX4qJHlmfHUiaOXIBZ1Jr43TD8xFR+POj/pAAsCobm4nx/et/kFpt9QARjaGo16djInxQT6MkHm1Fzhe6elA4A2RS33mU/Ig0hDYjcpOb7EyPIoY51FAlpom+8bjbO/Q5SiNLF8qw/7BcWyWr6b4oTgZIwo3dgt1FG1dQQU9divTff10Q1h4ueR+Ps3KezsP4ioLs0Neh/VrMizg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtYbm5Lx94XLVnNE7P2S8i41RzBoDv7FKFUSaTc0yuw=;
 b=C3DNcm8Q2ka86hLQR/6gbD5VrwHGrD+H3JFMdXmh8O8NpoUhNwYX8Ix5qfYYk1CAafhcm+XVNvAcvusfTeOmBDJ3FGgb3GQKAAgpwXYiHJbj3iX9RPlrgOaTb/UQ0NwADq5zOflngT+WYr52dMlSsRC2Nrs2RpUEVCX4Eq68W3s=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by PH0PR10MB4405.namprd10.prod.outlook.com (2603:10b6:510:40::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Fri, 27 Oct
 2023 23:01:11 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::c8c3:56ba:38d5:21ac]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::c8c3:56ba:38d5:21ac%3]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 23:01:11 +0000
Message-ID: <f374e4ac-807d-48e4-b339-b785fabfa2c3@oracle.com>
Date:   Sat, 28 Oct 2023 00:01:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [iommu?] divide error in iommufd_test
Content-Language: en-US
To:     iommu@lists.linux.dev, jgg@nvidia.com, jgg@ziepe.ca,
        kevin.tian@intel.com
References: <00000000000005f6aa0608b9220f@google.com>
Cc:     syzbot <syzbot+25dc7383c30ecdc83c38@syzkaller.appspotmail.com>,
        joro@8bytes.org, syzkaller-bugs@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        will@kernel.org, robin.murphy@arm.com, shuah@kernel.org
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <00000000000005f6aa0608b9220f@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0201.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36d::18) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|PH0PR10MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ace179c-59ec-4f4f-53ff-08dbd7409c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cFZmI7+82dnNZ0BPlR5LuqGay6QOOIbmJY2C+sYfdyRmf+3kakOyEU2PxLxz8g6zgwC6lA9VWGJEMWw6NGSzh2+/DuQ4j3wGgzsgz+HMYmDhiefCBQNJQg1CGwJ30EHZTsZhtV1naQNOUJsT9wuKfHzVHY9aMBejw4zq4KbRxeOGBMiraGBtMtNFDUlpDhe/x9R4azvCQomVQJn5WiwLBI58lTjQYneUlwzHbXma57NV3A6yvFWeZZ0fOsVojtUdSWkYGZ3x5BRSQL+kBsFw83v9ASKreDLphcb10uuNfHH0SnCtVdVMOEtPSctR/CUctOcFRFoIZbE36zORRKooOEOUlBPNdPuBb+e9AErmI6RQrvEOBI+1712M8Y8GhK3AOoscpO6+tEx1I+2CJjcJXO8GpURky0Z+W1GXnh3KRRHYj9/p1aGRT/1Rea23FKFiHKqDFFsRskjhStQXDObAG37hYlY+JmiBUVpl1McoK5lBB2AMQY1mUf46W5Ob9gEC6FjMqjjvOULQZvMSXKlvdStFKKMLM7uTKmqJX3p8ZqMGqwTegYv78+CAiLv8iZcd33tLXig6z6g5Hk4G1wEQjwY40hTl/Mb2TnZ61KUNgScwtK5mze2FH0XbK1WWFZMjbtdTV8yyQhgo5JnyeZiRjM4/jO+HbDB9SC7MI5kEjhK4ajKj/OmHgXuIsvkohMOlSMy0dliO9DjOzXEK4aAhCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(83380400001)(41300700001)(2906002)(7416002)(31686004)(86362001)(26005)(36756003)(5660300002)(2616005)(31696002)(38100700002)(6666004)(6512007)(966005)(66946007)(478600001)(6486002)(66556008)(4326008)(53546011)(66476007)(8936002)(316002)(45080400002)(6506007)(8676002)(99710200001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWt0YngrZFJTcGJraDJ2K0pmOWVYdW84c01DRml3V1pnN1lBVUxLcW1lRkJ5?=
 =?utf-8?B?K1VoT2lqRXJ0TjFYQWFwamhkUHNVUWRodUJPMG1WNlpNM2VZQmZsZWJ5U3M3?=
 =?utf-8?B?NDd6WGhNTzVBckwvSzJDV1NBRHRQOVNVRGxobGVLL1l3SDdXN0NHVTBnMWxs?=
 =?utf-8?B?UnVUdkFvWTF4WWhMVC9IeUNNbTV6bnRTTGpTRU9LaGFZQlhmZUVNRWxBRU9W?=
 =?utf-8?B?MWkrK01TSnpyTTRHbW5XcVZqWkpwczA1SUo0aGpySGVsMU1mR0FJOW4zSDJL?=
 =?utf-8?B?aVNGY0hlMVZyUkV6QTJvY3RHN1U2c01lUFVVVVIrOVNZM1U3QTdhaVpscHVi?=
 =?utf-8?B?bTQwbXM5ZThiM2pzbWl1Nnpma1hTQ3BWVURjZzRQT1dvMzJzTllzREVieEwy?=
 =?utf-8?B?U1NrcE1la1A3R0N5aU8zdEpmc1FyNjFETGpYNHZ4eXJrc0tUbnRMSTdLL0Fm?=
 =?utf-8?B?eUdXNloxSWZYc21iWW5lQ3B0THdZRWJqZyt2NkM4U2xPT1BobFpTQy9uR0Vs?=
 =?utf-8?B?NU1PSTV0VDFiWnU3R2RMVmlQQ25OdjA1UjNMT3FQK25GekVNYkhXNkdBcW9h?=
 =?utf-8?B?U2hGbEpYY3dRRnVBdlNNS2xxVkZxdE9hUjVUcnlITGpnRHBZeFE3cUNHb1or?=
 =?utf-8?B?YzFtMUlOd05kangzLzZSQkwwM1NLNm1OeUthREE2S0ZNQ2tiRlFpZ1dZQUV5?=
 =?utf-8?B?bnozS1lKMXR3UXJtUUJMNHJXZE1FNDNsNnpHbkZ0bXlPV3FBWUtkOHI3OTVa?=
 =?utf-8?B?TGRsVUQ3K3hhbSs0a3Nmd0VCbXdxNnhpaFEvSW1jbld1NUFUUEszc3NLVWNH?=
 =?utf-8?B?MXNuaHd6Q3JDRFp4LzFQNXFOSVlCNW5DbHRmaGxFNlpuNkE2QjlhYlNrVVpM?=
 =?utf-8?B?bE5TM2NCOUpkQU9mWE9lamZuQ29pN0cyMG8vM2ZxZjFlVVBxSlkwZ3oyWThN?=
 =?utf-8?B?RU5KY1FPSWdDVm14YUc5MEp6VVVCODdrVVVFa3dIVlVOWFZTYXkvRUYwaVZ1?=
 =?utf-8?B?SThxOXQweTVZY1VNMnh1TUtQMGovS3RyRURkR2FBSXMwZ2MwTHRIdVhHSTM2?=
 =?utf-8?B?N29pd3FXb0xHY1NlcVlibTRLcndKdEV6c0plS0JDMU5Fc2wxU2pDQ2YzaUtm?=
 =?utf-8?B?VW5IekhrNTZ1UG1CV0ZNUGJjeEU4QnJvSytGVFFsVGZWbWdHbmR2VytTd0o4?=
 =?utf-8?B?VklLd0xkeExoMmZQejVUTkd0ZnF5L284TzhEajdCcUN2em9CbmFwNXFCZDdO?=
 =?utf-8?B?MEMyVmhEMFZyMjR4K0xadzVDZHZuS1V3ZHhKeE5NWThuSEpzWm9NNnNWOGlr?=
 =?utf-8?B?QTVVbDVzSzU0QUpzZ01tS28vNGVqREdkUXh2MzgvaXZNWGg2Uzc4MkxaOTll?=
 =?utf-8?B?LytHRlNXWGxtQzY3NCtpRlVMbTlpNmJuM1dOSkpNaGFFWksrdjZ5eWE1alpu?=
 =?utf-8?B?eDk2V3dDdnYrNnF4bnlYVDZBWlcyL0hJUUNEb044UGxCQ2pGR1BMU1EvalBh?=
 =?utf-8?B?ZlhTZ2FaTGZwZGJ2eGhYdmFRbGF1bG0rVnBGKyt0bVFiT1ZQTHovZjhCaTM3?=
 =?utf-8?B?bGFCTmtBcWxzUXdMbkJSRHJqY3BDbkhZOTZSMVZ5OEwrdTFaNkJuV2xMSm13?=
 =?utf-8?B?VWZpOUdrS0wxaXhmUHV1cXB1a1N5QnBRTytLVkFuZWltWDdNQVlKcm40WnlB?=
 =?utf-8?B?MHVRMlV3aEFsUWpGSUlsbU8vWnZ5S3UyNlIyV1NSYVRWVUVjR0Q0cFpQNE9L?=
 =?utf-8?B?YlY4Z2NXcnR5YWpvaGhRRjg1VEcyMWtMaWVadkJhVzdBbDJWeWdYRXdqdy9i?=
 =?utf-8?B?OTFBcFdFRjBNWHM2RmJuMzZYWGZpL0hxQnUzVVlmTDdaSHV6cWxYN0lUMVcx?=
 =?utf-8?B?aWpVb1djN1U4L00xdmpHRUV0NGxJdEhsNkJrb2xLajJ0SVNMRUtaa2RwR0xw?=
 =?utf-8?B?WVplc2pwQWxmeTN5bGRDUUFJSVVoWnU3VTFYU3lyQXpXQzRXTUVRSGdCVjFh?=
 =?utf-8?B?RWNZWVZpRHpJRUVlczkrN1dHVlZlWmVkZDZKd0wycXhDSTVmM2piZ1FpUG81?=
 =?utf-8?B?UmhMQ1d5NkZIZzUvZ0s5MDBkc3BXenFzTnpUYWhrcTdiekwzczZGdlIyL09x?=
 =?utf-8?B?T201c3cvbDJzODdvbzNRNVRERTV1ekNnM2lBVHhYQUc1YnQ4cURzU09zU0lr?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TDBia1RPZDNRcG5JUERhY3Q1WXRjeHRWaVhnL0FVM0hydHRPZ0x4aXBVeG9s?=
 =?utf-8?B?eFpoMUdqeHBlY0lSdDlDblMyMEUrZjhDejVpRjcvaG5jekYwUFNleUNDMzRk?=
 =?utf-8?B?SGxpVkJQVkg4UGhUZkdsY05nYWpjL2FuSFVybzdZL3FnTVYzWXZrL0VnUU9L?=
 =?utf-8?B?SUUwRlJsd0FJeEMydzIwT3o0S3hjM2E5Tkk2VjFwbWRNZjljNi9MU3VyNm5q?=
 =?utf-8?B?S1pNTkQ2ZzZtZjdwRTBUTVZGc29DaTFjbHFyOEhLRjArM1pTYWJlKzBaSlZH?=
 =?utf-8?B?SkJLZk95ZXJxT0ZNNmQva2JuNS9UOU1aN0dGdmprUmRZTWVESG9lWE90T0cw?=
 =?utf-8?B?K1Y4YXVISUcvWWxkOWp5TitIRnNtT2NkWXNJdWJnQVpFbTBOVVh5MS8zQUda?=
 =?utf-8?B?cGNHVmhIRm1oeVlnK09LR0hMRUlPNGp0NmdSa2cyM3VFTElEMVF6NWFnSWQz?=
 =?utf-8?B?S2NCZ0hwVlQ3YTREcHRBbVNqeUFZdjFzbjBHUTFjRmovd0xIZXhFMmRHMkdC?=
 =?utf-8?B?REwyWmFFUHk0MnF1MEhZUWZjMzJtaVZPaVNFeVk0TlB0SmJUYUF0NzZ0Mi8w?=
 =?utf-8?B?dHc0aHB5YjFtWnlGSnpIalBualcxRCtKNmU5RmI2YVFDL094V0d5WTdJUVlw?=
 =?utf-8?B?bjhXNnlGUlc3T3k1UVR5Wk5qaWtZSmNDcEx0b3BQa2Z2dFUveTEvQTBUVlMr?=
 =?utf-8?B?akpPYUd2Skp0RlVFZXVCSlZyaE1ZL3duZUNSdldKcVYwR2RMWE1LYkxxVVRJ?=
 =?utf-8?B?bVVYTWc2bjV5ZUp3eU1kNTN2bVVaRUR0b2dKMXhVNzUwNWZsL0Z1UUpJdWxv?=
 =?utf-8?B?MERFdDJSeHY0RFY1UlhoYlE2YkdjUVp3WEkrTHpqbE02czU3UEptR1dCZGt6?=
 =?utf-8?B?MWNpUGpUMW01RzJONzIzQ3Z6b2IrUFN1YnpsSTZOUWs1Zm10VkVDV1dRTEhM?=
 =?utf-8?B?WWx6ek4wdnFCdGtvaE00VlJaZmpMSmYzS3pzT0hmbjY3dmpCbVlzb2h3bWYx?=
 =?utf-8?B?MG92alhKMjFrNHEwVEJuUXc0Y2JvUGwyVHIwK2Q4NjFvZnFjU1h4MHdSZzcz?=
 =?utf-8?B?Q3dPaXVOMHRtR0NjMUhIMElWNmkzQ3c3aWJnSmN5aitOSjVXL0MzSkhhMTdm?=
 =?utf-8?B?MW1Cc3RGcklaTjk2OHB4cXlXUVhpT0Z2M25zdmpSR1hkTE8wR2xWcjdiQTE5?=
 =?utf-8?B?TFhpc2lTN0ZUVW05c25GckwwQkJEQ21idVJVN0txWDRCK2JyTU9SaXd3UGEz?=
 =?utf-8?B?eXdYdWZTRVQzTGZBK1FzbVhlNExmaEk3REFFQTJMWFZwZ2RhRGJGVjZ0RlpJ?=
 =?utf-8?B?d0FNSE5QTTRJT0s3VS9lRHA5RWpIVTJxZjhUNU1KNG0zdVZMWEJYanF0T3FE?=
 =?utf-8?B?ZHU2VE9lQlJNa1NrVmVTdUYyQm1ZT0t3bElOdmx6VG1XaEtHWjFVY3ozZ3Nq?=
 =?utf-8?B?QjBEdCsrUVFhL3JranVEaTNkMGhNb1lDMGtxY1l3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ace179c-59ec-4f4f-53ff-08dbd7409c7a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 23:01:10.8067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tYW1I1nH7Brv9hEjN8ZXw7X9ZjjdW6R3rAmGZgn9lViMNQ30JbNo0m8DfhuZLQIY5LANrtbSKDwqmcgYUQRJM8gnytsCpcdz+loaVFml3/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4405
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_21,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310270196
X-Proofpoint-GUID: 0JnL7jRR4b1MCTtv5YPYSadRxDg3pd3d
X-Proofpoint-ORIG-GUID: 0JnL7jRR4b1MCTtv5YPYSadRxDg3pd3d
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 27/10/2023 22:11, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e8361b005d7c Add linux-next specific files for 20231023
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=13e4cb83680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=75e8fc3570ec9a74
> dashboard link: https://syzkaller.appspot.com/bug?extid=25dc7383c30ecdc83c38
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119bad5d680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1062e393680000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/e28a7944599e/disk-e8361b00.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7dd355dbe055/vmlinux-e8361b00.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7b2a9050635d/bzImage-e8361b00.xz
> 
> The issue was bisected to:
> 
> commit 5e054083ce6929b567c6aadbf8bf627b0f028353
> Author: Joao Martins <joao.m.martins@oracle.com>
> Date:   Fri Oct 20 22:28:02 2023 +0000
> 
>     iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP
> 

It is missing a !page_size check. The only divisions that occur here is to
page_size; perhaps I should find a way to reuse the check_iova_range I added,
and I don't need to replicate the same checks that I do here.

I'll follow-up on Monday.

> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a49a35680000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=16a49a35680000
> console output: https://syzkaller.appspot.com/x/log.txt?x=12a49a35680000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+25dc7383c30ecdc83c38@syzkaller.appspotmail.com
> Fixes: 5e054083ce69 ("iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP")
> 
> divide error: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 5053 Comm: syz-executor178 Not tainted 6.6.0-rc6-next-20231023-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
> RIP: 0010:iommufd_test_dirty drivers/iommu/iommufd/selftest.c:1098 [inline]
> RIP: 0010:iommufd_test+0x1fd/0x35c0 drivers/iommu/iommufd/selftest.c:1203
> Code: 04 02 48 89 4c 24 28 84 c0 74 09 3c 03 7f 05 e8 69 ac 2f fd 48 8b 04 24 31 d2 31 ff 48 8b 5c 24 20 44 8b 68 08 48 8b 44 24 28 <48> f7 f3 48 89 d5 48 89 d6 e8 85 cf d8 fc 48 85 ed 0f 85 ce 22 00
> RSP: 0018:ffffc90003937cb0 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff84affaf2 RDI: 0000000000000000
> RBP: 000000000000000d R08: 0000000000000005 R09: 000000000000000d
> R10: 000000000000000d R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: ffffc90003937e40 R15: ffffc90003937e00
> FS:  00005555560d7380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020006000 CR3: 0000000075a85000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  iommufd_fops_ioctl+0x35a/0x4e0 drivers/iommu/iommufd/main.c:404
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:871 [inline]
>  __se_sys_ioctl fs/ioctl.c:857 [inline]
>  __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x62/0x6a
> RIP: 0033:0x7f5fb02172e9
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd74d26068 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007ffd74d26238 RCX: 00007f5fb02172e9
> RDX: 0000000020000140 RSI: 0000000000003ba0 RDI: 0000000000000003
> RBP: 00007f5fb028a610 R08: 0000000000000000 R09: 00007ffd74d26238
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffd74d26228 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:iommufd_test_dirty drivers/iommu/iommufd/selftest.c:1098 [inline]
> RIP: 0010:iommufd_test+0x1fd/0x35c0 drivers/iommu/iommufd/selftest.c:1203
> Code: 04 02 48 89 4c 24 28 84 c0 74 09 3c 03 7f 05 e8 69 ac 2f fd 48 8b 04 24 31 d2 31 ff 48 8b 5c 24 20 44 8b 68 08 48 8b 44 24 28 <48> f7 f3 48 89 d5 48 89 d6 e8 85 cf d8 fc 48 85 ed 0f 85 ce 22 00
> RSP: 0018:ffffc90003937cb0 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff84affaf2 RDI: 0000000000000000
> RBP: 000000000000000d R08: 0000000000000005 R09: 000000000000000d
> R10: 000000000000000d R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: ffffc90003937e40 R15: ffffc90003937e00
> FS:  00005555560d7380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020006000 CR3: 0000000075a85000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:	04 02                	add    $0x2,%al
>    2:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
>    7:	84 c0                	test   %al,%al
>    9:	74 09                	je     0x14
>    b:	3c 03                	cmp    $0x3,%al
>    d:	7f 05                	jg     0x14
>    f:	e8 69 ac 2f fd       	call   0xfd2fac7d
>   14:	48 8b 04 24          	mov    (%rsp),%rax
>   18:	31 d2                	xor    %edx,%edx
>   1a:	31 ff                	xor    %edi,%edi
>   1c:	48 8b 5c 24 20       	mov    0x20(%rsp),%rbx
>   21:	44 8b 68 08          	mov    0x8(%rax),%r13d
>   25:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
> * 2a:	48 f7 f3             	div    %rbx <-- trapping instruction
>   2d:	48 89 d5             	mov    %rdx,%rbp
>   30:	48 89 d6             	mov    %rdx,%rsi
>   33:	e8 85 cf d8 fc       	call   0xfcd8cfbd
>   38:	48 85 ed             	test   %rbp,%rbp
>   3b:	0f                   	.byte 0xf
>   3c:	85 ce                	test   %ecx,%esi
>   3e:	22 00                	and    (%rax),%al
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
