Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9FC6EE66C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 19:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbjDYRPS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 13:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbjDYRPR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 13:15:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C011990;
        Tue, 25 Apr 2023 10:15:16 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PFxZLa016391;
        Tue, 25 Apr 2023 17:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=6YE87MdaktRYS1lOl64RJiRlm/c989Atw0DZqa1vKdw=;
 b=hW0NqMMfjek273Z3FEGa72V/rF75fgXriHYEHG9ul9IEdGLC1mlYMgcTAFRf0z4IavQz
 7Lo5lGILFM5JSVTdwaWyHeRUbqQfGRl2Ypv0AieXg18mYatIAJqNhzqKoEgreEjqzHBG
 gvD03hHZmC5cfeXKt5CVg5ewSpdfXfjoenSHUu/4t2df2iA6jn2hrcewt5pvwPlgn3CD
 0x8aJwYJfeUBzsOMMSrR/nsTO8O5F6EaibJl/uDCYSDJPFgmK0inEsYYkrrbs2QrEuvr
 Np5/cic+MUxgGhag189RBL83Rj5k2lvdmi8unU8iBOXRah7/dyMH6uWORXezwlG6Vx/D 7g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46gbpj7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 17:15:12 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PHDT3m032632;
        Tue, 25 Apr 2023 17:15:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q461705dd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 17:15:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hxyw/qmu6WhbKJ4iLp49QrxC0xwZ8xiQVJ4v479kTOqdL4Y3rxzXCNsMRkpddvWhPn+FgTGOCdQDo/f0C7e6m2mm2wyNDLKFwrLurS7BD7armXW2o7bYUcZytcP+IomA5GggdEWaLDBIpd8gUFzIpWiIdwSw5IVNOvLJ25OIkQXpkkTBPx668sC42tWHkSrieKsg8bYpjffg2dZGYg8FhiGWwYn4NW2vzZOrYBs115t4U1EdOdxZmUagGtKjMGreOkEytKvXGoTS7T3SqjA882awF1MfRO54kd18mcdKbJ73q+SAMWlCK4emq3NFbeOivfj46k4l1xIfLvSCu+/rrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YE87MdaktRYS1lOl64RJiRlm/c989Atw0DZqa1vKdw=;
 b=oC3Un4EDa7wYbGiL+N6wEg4j3CnY/PndoDVT1BxHQFCx8mgI1HowLOESjXZ2YbsGx6z9prB43CUkomx0D3UY7pEr41Htm0pB5C2fEZnRRNrDOEiU22p5UoZ02vyhu0M/ieSuDt46p2nbuDaaqhjfeQQZi2sagTQvv30+nWY2fB3YNv9ET3l02zuv9l2XzXf4rsVn3mE8ZlI7kGV8DR5to3KbNdgGU6cl822AnAmmxiaNG8PzrB5zcEZTS7VpuZqmCfW/3BBhASs4rG2UNDeVuYUXKGkPAmIzWFPqgBiBXkygc1oLlK1MfiYwNgd30+KKZxhhhIzE3Kr5IxXBN124sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YE87MdaktRYS1lOl64RJiRlm/c989Atw0DZqa1vKdw=;
 b=Ls/S/Gs1HovofmWC8dZJHjaU0oSzBZodJTuSFkL8cXdAcDahp41eJ4ZYXRmzA6MezRUgp3cOPqNVViNF9PyHpS0is1JnbvGI0xZaRVdNVHz/m4Ja4NY73sfBPynOk09T1dR0N/yAgPnzW2+r4+tjZs27kPmI0hgQfC20V1YcQR0=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CY5PR10MB6046.namprd10.prod.outlook.com (2603:10b6:930:3d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 17:15:09 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::90e:32fb:4292:1ace]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::90e:32fb:4292:1ace%6]) with mapi id 15.20.6340.020; Tue, 25 Apr 2023
 17:15:09 +0000
Subject: Re: [PATCH tracing 0/3] tracing: support > 8 byte filter predicates
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, corbet@lwn.net, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <1682414197-13173-1-git-send-email-alan.maguire@oracle.com>
 <20230425233233.2ad5168c630b4c1349ab3398@kernel.org>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <9c4cebb7-514c-f7fd-1f95-50837460eb66@oracle.com>
Date:   Tue, 25 Apr 2023 18:15:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <20230425233233.2ad5168c630b4c1349ab3398@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0012.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::12) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CY5PR10MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb1f02d-d791-4042-450d-08db45b09f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UtyRpAL2ZYQfgk12D22qCBhkt5EOi7XjT8qWVynkGXnVO7+QPqcigs6KWp6LxZCnULwVlnulCzi0VO2wyFYfzhjjONtkMkoTFXVscihH7ImYqvXv0TDoMNyv5SVtNxRBo0scbJkPTjXt8sPp5kWUYfQNfXoKrs5VgsdLG6BoMOMbOuj264368z6roQYG0dtU+PNy0Jv4guDDPI5uJ7uHilt5ebcCzDflxblrJc9v0bKEURZiDcrwgISVq/UEzGCVn8hI9wCt7LfEQoQPbKIOLlOhz3Tpa1zCnO2fomn5XbKgfepQIRJxgKKzQ2TOLsDwAvD3qmnZYF+ek4IwRuM7hVlCLXH30NfINNtEk7ItU9Occ0PulC22QUDdb800MgsCR5qZk/o0LF/zybuFzMkl0q8xWEiTU4apzwkmrtQrFnl2u/V+bVqL0EmGHmOodMo2N2KVpGGNzGzLgZDfnmSWLMjvmj8WcMC4NPbaVASKH3LcX0cuJ1G5T19NdQ6/7x7wY44zTLHrmIurdollLf1lwzVFfIhCrxnipL8OO9kOQFjyluMZkTX/bXVqrjZ+/jMRbptGooaNVvmU0WfF+UrfCvHNLIFVBcaxWHuhJewD6LLrINwfaq+g9l38xtjz3S/W/nxr/sBf1OMfS/Zc/gp9XQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(478600001)(31696002)(86362001)(966005)(36756003)(186003)(53546011)(6486002)(6512007)(6506007)(4326008)(6916009)(66556008)(316002)(6666004)(66476007)(44832011)(66946007)(83380400001)(2906002)(38100700002)(8676002)(41300700001)(31686004)(5660300002)(8936002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWVrMW81WUhRYkRQT2EvYzRuRnFkVnlleU0yeWo1cWpnSDE2L05hbjllelFG?=
 =?utf-8?B?ZHJFU3VOc1o1cHEwOHVVZncyU1pnd3FFTnFLQWJCNEY2VkpEbU13SFRvcjFX?=
 =?utf-8?B?ZkJPTFZXVjF0OTg2ZTlYNWxTU1FzMkJXUVlJQXBkSXYrTE1HWG5hVDN3eUNr?=
 =?utf-8?B?Qi9LRS90ZStJQitGZ2NEQTNYVUxFRXZtSTVkcWU2RzJrOW5JOEYvMjUrZ2Zi?=
 =?utf-8?B?SUxHdVlrOUtCS2Z3SGxkaFVVQVZqelFoeFcwRDg1ZGEwUUowaHJ3d25GT1Zn?=
 =?utf-8?B?cjRTZWwyVFJTdnJWRVZ1OWxwTzJ6K3VrUkxWNHhVSi9QeVkzS294MUplM2JD?=
 =?utf-8?B?cVRzN3FudFZLSGRnVHAzWkp4UzNhMHpRKy9wSmJiRnk3dEgzNVU1d0JaZ2RZ?=
 =?utf-8?B?dVExVjh4cEFNc25vdGpMeE4yOEV1VDRPdmlrRHlCUDFCVHV4UEEySytZMklh?=
 =?utf-8?B?akQ3RkpETEY4NGR2bWhhQ3VsM0k2bXhQaWFuVWJLdVhzcWg2ODMxa2RWWWVD?=
 =?utf-8?B?UEwyd3pMM2wxanMxUE0wcmUreHJKVUtDTEJjRUtXQzB6VWFZMEVVVEw0S1I4?=
 =?utf-8?B?WHRCVXhHdDhWbyszUFBxK1NaUWl3Z0IvMDNUaFBrTmoyaFR2KyttZHd6ZEkz?=
 =?utf-8?B?eUVGRFVyMjZSSDZIRzNKWUxWdzRnWCswRDB4cmpvZUlSSGdqdTJkK2hVbzA0?=
 =?utf-8?B?anozTWI1b1J2V2N6MzhwLzV4ektESTAwZDZyeWtjd3k3cUNrWXc4bjJtR1Z5?=
 =?utf-8?B?ajIzeWhaUG5jdzNhMjBFKzRsS1U4dnh1Z05RQkFraGU5VXBteStUR0Jwd3ZP?=
 =?utf-8?B?SEZKQU9yenpvYVBWUFdsQ3FPT1MyOE5ZNnZ3dnl3bmMwQUlYV0dGWkxjTkJS?=
 =?utf-8?B?SkFPTTBaeXFqdVhYd3AvcklWeXZleVlKZkhOVjVHRUEzY3pvWjVhYnpmaWZ5?=
 =?utf-8?B?VkR1KzVpWnNlS05RWXNqajY0MVJHbUs1NzNpUmt2L2ZUM0pZeE5jZWF5eEMx?=
 =?utf-8?B?UkZNbE9TYlhkNHkwNEdxTW5Ha2ovWXpBRWVNczNHbXdKamhFcnNGU2VBK3Rn?=
 =?utf-8?B?QVdqNXF3UEd5TFdtcGRRV1NNTnI4NkI3VUJta1Q0REVYZjZIUEhNZElxNXdv?=
 =?utf-8?B?Vk1kREJRWXNTd0QvNlhXUUpSQUhtV3JJaXhHRWJxT2dzS2NpalNYM2lLcnh0?=
 =?utf-8?B?NUdyRFdHQVR4UFhTR29rLzc3VmdFTDJna2FKY1pBSG5hdVBSZEM3VnRRRmZV?=
 =?utf-8?B?Qm5oTktyRVdGWmtvNDNWa1RXQksvaXBTSldZYmhIM1J2RSszZmx0OFdWem5J?=
 =?utf-8?B?ZEd1N2Z1Y2VVYWl0TTNmT1oybE8xQXZIa041aEdQZkJMczhaN1dTanAvSnR4?=
 =?utf-8?B?Uk93amVSMWxyMTh1bWl2VVN3QnQrYWtGRUZ0Q3RMdHZwVHpHaVlVOG90VFc5?=
 =?utf-8?B?N28yU1M0MktadFZ3ajZrS2ZyeHhmWG5GdExSSXpEeVJ3bXpxbFVqcHB6Y01B?=
 =?utf-8?B?MjV6Vll1YVVNS04wbEhHUXBKYmNEc1gvTFc5SGpDTTRyTTM4eHlFUDQ5UXQ1?=
 =?utf-8?B?OHltYTViQ2NPa0xNWkkxTTA1OEZhczhPUG8xRlhDU2dxNncvS01Mbllma3RC?=
 =?utf-8?B?a2pFWDI3V0RzTHNJd0hnQTlhQTJnQlRKM1AvMkJ3UXViKzVyMVFnaFk2M3pk?=
 =?utf-8?B?Q0pLZEwzazk0amlNd28vM0tsSmQ0UW1LMEFHazNNWmFtYW9Nd1dmV0NWWHh1?=
 =?utf-8?B?MnFhSnNkRURjUXRzM3c2ekhRT3AvbU1URGE5ZlIzSTdvNWt3a0pkdlFYcmtZ?=
 =?utf-8?B?YlJwTkpJZS9qL2RFQVlJcTF6MWgyMDZTMmhYbDhsU3NQTHZrM1dUZlBPUTVZ?=
 =?utf-8?B?V0tkQTFNUit4WnVHQ0pPY2xqMnduYjZBNTFYYkJFb3ZqNWhzZzhadGlHd1dk?=
 =?utf-8?B?Z0FkTnhzY3FVMzI3VDJEejdQbkNYaFZmMWtaUTRyRGV5d2JFWGduOENIZ2p0?=
 =?utf-8?B?WEVDMXdJM0ttOFhLalFjYU9ZL0FIWDJKSENqd2FuMlI5N3hKWW1zTXNPWk16?=
 =?utf-8?B?QjJQV1V5clFaby81czZOYTBXcGdvemtsNDRaMGE2QXErMDdsZHBRYU9UbUlx?=
 =?utf-8?B?UGZEM3dTWk5lWTMrWU9jTjE0bGdGR3I4b2JtT0dkaEpncXZwaFdqQThCTXVW?=
 =?utf-8?Q?PVj52fLYUSneY1CjJN46jqs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AEVVEiIjstq0ZhgfdRSnd8jK4+jpBBZKeTTUjn2z9bYzrz+MX19wBXUIWtF3BLYe9IwVjo8Fi0/hzeFXzXgYNIY27C3NAUVzZLzjDwE3hNQG4UT3pvy0FU8QAfNHGnAyNUrSkZob2iaBoZ0uvKiA5cn6XS6UH0eWvDiK9Or6l0DZ1wsOjjKJtawzIbYypox6p3KVEGgKecllPJWMevA5OrrCEp1FRN5i+FphT70OT8qTgE5VnubfdoBB3QvtpNJXVkb2r6d/Dar6LkYhdSSgafldqR4840EhPhl0hSxjwNj+fwkmxqJHMO9sQ/frH9igfUrZ1xh9VnaHDHPx5zSt5j4TYDVL2KxKteVevNTd9zkOTDApTP19Qq4dC45AdIvKD7CoINc4wB+upnZqtQcar1opbQTtNYKbX++r5AUUPrpJhnjeHGo31UVUncCRt1KCuggMCy4gJ76awg8eIwVIkR7ABbbWgS9jcxoCnMAGxCJyHWoeapRDvnnnNTigusMUpjIfmQsy/NRW+TM4Jl9eu+bMeZUi54rEZr33qRuoLXva31OWLX0PX0cY1IcUJLAV9NK9OUrJwSa9WMCPT6EDi1PQWk3kX37zTxXZRgvw0WyvK6MUSdkqSGdzRk+L2FB1rWKKxjzRVE7gmN+p3S5fHo5G7Hxi8Cp+jkQosA69I4QDONYynXVzkf1YYe66Q22yTj4zNw6SwMiVvyyRULrCeL4NJfmNczdJxrqq/4H7/nYuCr7UnaQSBO/geiIlU7oPCLPgtq1sBdSOK0od2fZNVF3Dx8QbEuHh5ABAcBwD8yUOBMPx/ijZ2jegLBJ3wnb3mpRBw7okClWAFyMioNlpXg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb1f02d-d791-4042-450d-08db45b09f6f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 17:15:09.6360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+Ir5tItFJfwFERyCgWUNC1WpB3sO+X1TlfaQRWcxiwwIL+9/b676TAHHlCEGbjU0IDUeinhdKO9oIWsuhQZKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6046
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_08,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250155
X-Proofpoint-GUID: s40Hkwnz9cuwAhrEL_dveNu4ag6oW1vE
X-Proofpoint-ORIG-GUID: s40Hkwnz9cuwAhrEL_dveNu4ag6oW1vE
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 25/04/2023 15:32, Masami Hiramatsu (Google) wrote:
> On Tue, 25 Apr 2023 10:16:34 +0100
> Alan Maguire <alan.maguire@oracle.com> wrote:
> 
>> For cases like IPv6 addresses, having a means to supply tracing
>> predicates for fields with more than 8 bytes would be convenient.
>> This series provides a simple way to support this by allowing
>> simple ==, != memory comparison with the predicate supplied when
>> the size of the field exceeds 8 bytes.  For example, to trace
>> ::1, the predicate
>>
>> 	"dst == 0x00000000000000000000000000000001"
>>
>> ..could be used.
> 
> Nice!
> And I also would like to use something like "dst == ipv6(::1)" because
> it seems easy to make a mistake on the number of zeros.
> 
> Can we add such type casting feature to the filter?
>

that's a great idea; what would be the most consistent ftrace syntax
for this do you think? I noticed that hist triggers append a modifier
to the field name so would something like

"dst.ipv6 == ::1"

make sense maybe? Thanks!

Alan

 
> Thank you,
> 
>>
>> Patch 1 provides the support for > 8 byte fields via a memcmp()-style
>> predicate. Patch 2 adds tests for filter predicates, and patch 3
>> documents the fact that for > 8 bytes. only == and != are supported.
>>
>> Changes since RFC [1]:
>>
>> - originally a fix was intermixed with the new functionality as
>>   patch 1 in series [1]; the fix landed separately
>> - small tweaks to how filter predicates are defined via fn_num as
>>   opposed to via fn directly
>>
>> [1] https://lore.kernel.org/lkml/1659910883-18223-1-git-send-email-alan.maguire@oracle.com/
>>
>> Alan Maguire (3):
>>   tracing: support > 8 byte array filter predicates
>>   selftests/ftrace: add test coverage for filter predicates
>>   tracing: document > 8 byte numeric filtering support
>>
>>  Documentation/trace/events.rst                |  9 +++
>>  kernel/trace/trace_events_filter.c            | 55 +++++++++++++++-
>>  .../selftests/ftrace/test.d/event/filter.tc   | 62 +++++++++++++++++++
>>  3 files changed, 125 insertions(+), 1 deletion(-)
>>  create mode 100644 tools/testing/selftests/ftrace/test.d/event/filter.tc
>>
>> -- 
>> 2.31.1
>>
> 
> 
