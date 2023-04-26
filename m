Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744696EF075
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Apr 2023 10:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239880AbjDZIv2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Apr 2023 04:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjDZIv1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Apr 2023 04:51:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5038D2D74;
        Wed, 26 Apr 2023 01:51:26 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33Q6QSZ5019836;
        Wed, 26 Apr 2023 08:51:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=a2T1H5G6ah/sG6zn5yJn+X8Sq9K62JVW63n/djyNxKY=;
 b=lIFxp7jqkJ5cpMQPBbs1AG12LABhb+FrV2iwdhqBHADVrTDOJsN2RSkygECy2Q9SXZKk
 zPfWRvVM5M3i0GE0+762HqPdcHSjJE8EON+TgN1Y97z8N9pzJP10tWvQ2tvk5uxbzquM
 7VOl6kuEXSAAt5R5uW0UV1p1sTobV8wyMu1cMC4xYBdeB/as+S01nXKepSsZQQn9MOt2
 7egWHpZja6k4TOeUb+e230/fOSnwOrKWI3uryJBeksVBkt/LyM7s90vHks5aaHSlLQnp
 El7WzoajHr+DyQmobITtrPjwB6bkK5Z4zqoD+FO9FX3deg8qfYI7qgFXyfc4EqJUYqIs ug== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q460d8tw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 08:51:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33Q8JZ1k025092;
        Wed, 26 Apr 2023 08:51:20 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q461dw71h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 08:51:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLhD24Etdd8zDQKK9kj2NbIkE4FtpqM9HuBWpm+8hHJOQsGTwnLyO8DujmCpvjOC2Fzg+vM9k5MQsjF8hEOLk+4R0jJXyVdD5iLxkz7XzhLMQc50RDjraYuG04P2bv0cqxaq+IcvaBohQp1HFufCeCA74hoXH3DgW8OrnhxExZwnOtpL3t54JzX6lX0VCIEvMlRYVlMzB6cKhC9ZOzdejYpxCWcS+lUpP3jDknkuczcEy3gHiyvGCEfgq62WKGsBLFx+AL09WR1mQsSiyqz35BgJAJqWtqNXEhCjXIT2Qzi6Dos9OFxIzxsTUEkeclkg51PztYe1XseQ/JXlVXfP+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2T1H5G6ah/sG6zn5yJn+X8Sq9K62JVW63n/djyNxKY=;
 b=mKc/lJHXwZPD/B/q7QHimXNNcv8iQBVbDamJXa19QVW5aQeZjvvBLGoYcCZLlFoWnd90VkJI1JzClBAk87jYhnejuo112dAmVOrWi+IEvgEOW+HrxaO+EZNOdphQsr5UG/eyRcpGtoDF46t0tHCyft2Z/iTxmp6wpOu+zfZFfEbJYfxsBkX92+f578zwu/ITjTrQIPUaK1Mnyf0yqhXXEARtc50H4++YnpGO7yvOGhP83rQzYzqyQRScjxX1H3DzFHdDKxLjCtZyJzc8WXZOZstd2RzHi45WILRr0dH4v1/Ic61K2b3ZzEb56QReeFQvKlmXkid7AJHuuOx05cl+vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2T1H5G6ah/sG6zn5yJn+X8Sq9K62JVW63n/djyNxKY=;
 b=vioi7nnu309rJeOWXPYVxKDgFhJk3XHYjjv80TwxFh+UF8+PGEbH0zWmnv1HaSwGYcKZjI50eXmU+ymP98hXV3bZrkfEigFeHhSOGIDkILGLFuk1UqZHF2YDEP0dXTKDYel5ndCpwadYt2bbsq3puYDFREpCTKoBbcn5G1GZXLg=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MW6PR10MB7616.namprd10.prod.outlook.com (2603:10b6:303:249::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Wed, 26 Apr
 2023 08:51:13 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::90e:32fb:4292:1ace]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::90e:32fb:4292:1ace%6]) with mapi id 15.20.6340.022; Wed, 26 Apr 2023
 08:51:06 +0000
Subject: Re: [PATCH tracing 0/3] tracing: support > 8 byte filter predicates
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, corbet@lwn.net,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <1682414197-13173-1-git-send-email-alan.maguire@oracle.com>
 <20230425233233.2ad5168c630b4c1349ab3398@kernel.org>
 <9c4cebb7-514c-f7fd-1f95-50837460eb66@oracle.com>
 <20230425132028.7d16e04c@gandalf.local.home>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <57d8f27c-7737-8af9-490b-a33b2783fc9f@oracle.com>
Date:   Wed, 26 Apr 2023 09:51:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <20230425132028.7d16e04c@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0617.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::18) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MW6PR10MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d7aabc-7e0d-431d-052b-08db46335f31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FZKvNkwzy5fV+zusNuQoG93AzymGXdVBRp2JUYC5Iv70GS/jotVpIuyZGHLykmBdgyRxV1Or2CQOpKWpj+dGDjXmY+1SoyxuZXRa3yoTTh3nQa9IXaLokaKQ1uZWnpimt5EvrdvDiWDKL+U3yW91/q2MmqIkbVtbD+b8333Xai/MRrFS1I1VRIMKxVJfl/5ARWomo4FrQiD3m6nvLzgsSQCuWo1iE3mfqSCQRsZM56PzG4zhZwoYaJk+8FiLF+lPY+dNtXfyCfCuvBSsNJgpce+xNTRbr7ox9KDU+LoOaTdUPGbsHl0OJoQgqDIQG93vy3NfGRXdfGCw24mvNBr9MGkFBUjPAhjCNa41EUSK8YFFz0Xp9qILUBuW8ezLcgtxlZ0WSQORWQZ1/69ikkPBaDjIKOzJGhAX7g5WEqE2MXu0mmKxm5pqGUwX7fNo3hlGltKg3kA1lWHH4A5YaVb5x91Y4dI80QwAWsvWkh9XTgmzZKjPL0B4UrtUkhQHsI5/1HZYGOOE/ix1axuNHE/SazTmBZ7cCMY9NndKug8kghzQ8jVZ0U6ulilpxk3p0kY3rSUohXFeV2xa+sBhWfKcutmvUyASwmCUogfqpYbSuBepSTopyODOPhbdrMhmP2XI/aiEujCykz6OkRSbYWXvKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199021)(6506007)(31696002)(31686004)(53546011)(6512007)(86362001)(2616005)(5660300002)(186003)(83380400001)(6486002)(6666004)(36756003)(8936002)(8676002)(41300700001)(316002)(44832011)(4744005)(38100700002)(2906002)(66476007)(66946007)(4326008)(6916009)(478600001)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEZhbC9aaDFzRFI0ajZXM2pobm5uVm4zL2NhTDc4Qng1YmorYnFITkp5eG5F?=
 =?utf-8?B?M0hZTzFzMFNxbTdzZHJLM3RGTG9yTlpzb2VWa1h3U0MyQ1VHRFpjZ0V4Nitt?=
 =?utf-8?B?WVR6T0Q1YS96VDEzaUZjend0QjdEd3UrdVZXc1Z3NkJyQkxKY0RNRHlBc1RJ?=
 =?utf-8?B?QmJEMEE1YkMwZ2c5MHZvbHBMU1o3bFBUUGJLdVJTYVJld0VvQktrQ2pDQlVh?=
 =?utf-8?B?V0QrRU9UREZMTnMwM0pjcWFZTUkvOHFHbHJNbVNBdUM1Ni8wQS95L0Q4S0Q3?=
 =?utf-8?B?cWplRElkVlFFLzZhTkNRb2QyaDlFbXVXZWlNOGRSakduaTJOaGF2KzR3aEhm?=
 =?utf-8?B?ZGdmSGg0cTBhMlhOY1BKYjlDVFlFUU0rbTV3MVBvRFcyODY4R2I2WW0yNTVB?=
 =?utf-8?B?WktrT3A5K1Jlc2hBWktjNGY3dnF1NjdYakprRUVqQ2hXQ2lmVTZrVWVKUWhG?=
 =?utf-8?B?U2trdFJmR09UeU5ONFlxZ0toWmUweVZsYzlEbjlpb1gxUUwwRWNla2pkL3hL?=
 =?utf-8?B?OEdGNEs1MzNIKzdGSndxaC9rZm5LUHN1ajRUSTZNSmZERitmWkU4NWJvb1hZ?=
 =?utf-8?B?Yyt3MTJ1emMvbm9BQXVzQ0pjVVpuRE8yOWNVNEZEK0w4TDhoS0VBR0Z1eWRR?=
 =?utf-8?B?RXczS0FTQ0o1dW8vOE5aKzNndnp5VG5wOFpLUmNjQ1VuYmdwUmxudXFGQTVh?=
 =?utf-8?B?ckF5TmFhclRCZkRrSlRlc0ZzS0RaMDlud1VJMmU5RDg0b1A4TU91OEZGMlJO?=
 =?utf-8?B?RFh6NG9BYS83aHJKUmV2ZWlNa1VFVEdPWmp0ZUNZQmo1UmVwVGcrTWJiV3Ro?=
 =?utf-8?B?ZnFLdlEyUjBEeVh0OFBSUWRFWkdZR3VNdEZid0w3eG94ZXBnY2hUSWhlZm1i?=
 =?utf-8?B?U0RhaUVac2JzbW9uZXdGd2lhd3EwVGRqV1ArcllRdE8rdEJPQ0ZaV3h6eFFX?=
 =?utf-8?B?TjU0YTZ2UHhLczdjOEhCUThvRTlNU0E5S2dHVW1iZHRyS2hyNkpOdmNITHhT?=
 =?utf-8?B?aFFvZmR4Y0tyQ1k2M3hYOHNwbytZODM5MnM2MnZqNUkrQ3dwWGVRTU9SMGVE?=
 =?utf-8?B?Zy9ITC9RbS9lYWRacFFCaENCck5sQ1ViRjN0ckc4ZXhyZUtHb3BocldtN3hD?=
 =?utf-8?B?L25jM1d6RUZCMXFUTnl4dDRzZ0cwQlNDdG5jM2k2cHRwWHg1bzNwaExCOStP?=
 =?utf-8?B?TUFGWmc3NDJnN0FDVjFUTXFXY1BXZHFPd1ZJRHpHTkpIYWgrMTAzNTBKNWlY?=
 =?utf-8?B?L204SXl0VHNLL0Q4bkVkNjBBcTd1QS96aldUUUVGRFJZRkQyL1VjeW1MV3BK?=
 =?utf-8?B?cEh2WFRIa253eWU0aFlLbjh5L3B0V053WVFON1JhSkJ3THhYSDJYQXhvbkJK?=
 =?utf-8?B?enVQRlN3VUF1dlRQSjRPRmZrYnJlSnFhelN3M2crYndhczZqeTBBTTJRWUF0?=
 =?utf-8?B?eVNpOE82V0xXTGV6SWZiSjZxNkRHMjhYdzNFN2FsckM0aHNvT1lqTGpQenI1?=
 =?utf-8?B?K0U3ZWZseDJJQ3dDK3hWaHFZc3JibnQ3NWhXbFI0VEpNSlRETzBXYXBFdFkr?=
 =?utf-8?B?NStoUjhxRzNiVU80cjRGYXBFNzVNeVM1cmFrZyt6VTRlNkNHa1NXRXd5NHBY?=
 =?utf-8?B?aUJSVmxrM05LbUlabnhMT2svd2VmN2tRbkNsbjZRd1V5NWgzR1JuQThlK0VB?=
 =?utf-8?B?RCtVTGZVKzh1OFNVNFNaYmF2dHdxZWI3UkN6TFNpZUpuaStNM0FsVXMrcGFU?=
 =?utf-8?B?SG1wNHp0WnRMNkM5c20zbTZvNDU5c242MytSSUZ1NmJQZUh1M3ltcnZJTDAw?=
 =?utf-8?B?L1gvLzh0VGh6ZUFwV2lZMWgrWkFBaG1makovZjJoRUZZMFptczVldFNPT1hY?=
 =?utf-8?B?aVBtTmdyL2Z0TStUMFV3Mm1pOVUwNnJ6T3cwem5HaG0yckxWUGxTaE5Eem9W?=
 =?utf-8?B?bEVDc3krUFQrNExUTzBqWVBJRDg5Y093dSsyRHlDMWVIbjJUOHJuRi8zSU5q?=
 =?utf-8?B?VndrT3Zjb2Z3Y1B5M0lIaFBNT29lcjVDMDRGdEk5RHRUem9rUlJiNHluRjJU?=
 =?utf-8?B?MjMxcHNhcEZXVzJPZzZwNXg1Rm93UW1wU3UyeVl6SXA2NC9IazNIVXlxYUpz?=
 =?utf-8?B?VVlPbDJuNHhpOVJmUnpmMEVIS2dxbUhyRytQd0orRWR1c0YrcVNoa3lzSHNJ?=
 =?utf-8?Q?agZfg+1w98eg3t950qsAo24=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: J8Ngk1Wlc733arJ8Dd2EKdItABUmFtIme8Q5wNmHrP3pBaI2oV6Tah0Kj03GUeVgCsozbEDKYJvJSiuVF4E8v70sGYibiblHhb3KYC1ZyOmPd1nf+a6jht7oIqdZENTClZRQve2EIgO8IDbmEsm4uBvS/hZCIxwi5yYVgtN7YcXbZNiA+a+n2K0WmCEUMScOMYceDfVAtr2XOMXrahix/R+7/N+somoxsY80fSsYuXzSTItmAu5GesJd4YWb1N+ktkhTxMvrl6drst/lGntlJfPEb8dg50SgoC0BIbX5p7tPALMNWYW1G8TOtJp8r8a1IoZX3uMugz82rVWFJl44B2C7KE0vIperqNpJ6cB8etVZXS872TqNvaSGhCRHEZwcz+VI6gsy0sUiwjlqTZml8RnmCI+e5T4VO7WnNKBtcXer6VeyFrkNJVWmKIev5IsRNJDRLmEbAT/uGxbwZF6kxqGCi1xmVa1YnlQPji3X42R1Sa+sO9A225b7BB5D03dfAeCqPrc9K9qmAXsHb5t0IOurWhLn4roqmvlCgDgelwOk5iTg8nQvRCLToX2LOI0CSpi+X1kRk+EsOc4PhHYw+Kqqs+SIgptZ8jHfeuemhuYCuM3UuiKiIXs4v3q/JZSRQUSWnSEB3sa2N660Ju3R8r2pWp8fu4jDo9XZhX1uh3VkuPoHENn9H/UdA5+hnrW5m8/7U9VFJ2HqFI5Nq8THUJs8GFZjJMWqZy/DGlx+szUqG+LtmF4Zi8Ww9LZ0Pgpu0689pP5go0SRrvv2w/zROCfvTZ56hT8onoKMDWejITcvjAKZyDGg6nZ16qB80BniVX2eY5Qg7nllW/ACvNR1SA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d7aabc-7e0d-431d-052b-08db46335f31
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 08:51:06.1103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cAamw8Snt/Ye2jVtCwtDPsEcLCySUD3SE2lthMl07kASw8GaC8gZXIjXoP5ODe3nJb28U97zGz5Bl5k8RiHL8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7616
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_03,2023-04-26_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304260080
X-Proofpoint-GUID: GEmMZV5cj8MzRhwmG0W6TtSOBQCyTQ5F
X-Proofpoint-ORIG-GUID: GEmMZV5cj8MzRhwmG0W6TtSOBQCyTQ5F
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 25/04/2023 18:20, Steven Rostedt wrote:
> On Tue, 25 Apr 2023 18:15:03 +0100
> Alan Maguire <alan.maguire@oracle.com> wrote:
> 
>> that's a great idea; what would be the most consistent ftrace syntax
>> for this do you think? I noticed that hist triggers append a modifier
>> to the field name so would something like
>>
>> "dst.ipv6 == ::1"
> 
> Yeah, I think just having ":" in the name without quotes can help the filter
> know that it's a ipv6 id.
> 
> Hmm, although we may want to do the same for mac addresses. But we can
> determine the difference by the field size. If it's 6 bytes, it's a mac, if
> it's 128 bits, then ipv6.
>

good idea! so what about the following

- 16 byte field with ':'; convert from IPv6 address before memcmp()ing
- 6 byte field with ':'; convert from MAC address before memcmp()ing
- 4 byte field with '.'; convert from IPv4 address before memcmp()ing
- 0x prefix, any other size; basic memcmp

? Thanks!

Alan
 
> -- Steve
> 
