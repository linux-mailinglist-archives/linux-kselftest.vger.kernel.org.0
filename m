Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1C067152C
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 08:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjARHkW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Jan 2023 02:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjARHiY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Jan 2023 02:38:24 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BC25F3B6;
        Tue, 17 Jan 2023 22:59:25 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30I5KVWR013969;
        Tue, 17 Jan 2023 22:59:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=diW2MlU32EIJ8SnnG66eqcoAJSgDj4Ve1+hFTHXIRng=;
 b=oA3PbF+m/QECbM0jwbwteulbRHwuEyC4KwMJdpTxTvMO/FQiyLb62IrfJbmd/Kx6ORMU
 pW3feBkKlUvJ64gSVfDKmTmJxLq4W5L/oBsHurSEB806KarXxGjTpwldo24dl7eAWnkC
 LlnOfQ7nNqC2y8Y/x4FjfyJeq7jBlaSYwV2EFpyFe19gnRKTHQuPCXWQTCY3qjxphpl+
 Raa1g8VC0HvBbASdEQXkJAP0SDoIrX7dxp99niTWEDJ+7uBitGyfi0mEImyvAOfRQWuU
 puz++ja66HOcm6jBJ6xXo1XzQ/ieoinBdtIL+cnKcrglA47fFoHSg1m1Xo+WGVeslLNo Ww== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n3u16hpat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 22:59:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZoc87XXPir7c3Bmg78henO2r1l3lZNMOjWe5YOkoabH8TKNh73/5iSX+WDZG1FdWdoV4pGCkZYJ7l1hnilTORj5dR1mbNx+UmbaFShL10SC9I5ttwI33uINEJhOobCO5aGNFRhACyDyACf3V7+v/bsJzUGDxOk1UJTPy/e5+NFLVEqiF9MxtQKDEIziixikjGR/iA6mfA9f2HUG2FRbB+Q3cERAhZm7sZgpgzSwRou6Tvnw5Gpwv4/CnP5g2ec1NwnTkNb8iVn5g+p9QCiZax88Vr9ImCguTcBrQwZbXWsKwz5zE2GrLhFPmlS/qxKHhOqE5+TgcS0YQrzNgIJEDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diW2MlU32EIJ8SnnG66eqcoAJSgDj4Ve1+hFTHXIRng=;
 b=X8jcCwZZ9Wm4hPBhFUpMfJF0riVfQOuR2AMmTzwG69WlUajyFAWXnUIgzWExDEGjIyDs17ewplgazCIufaKReqCzWc6S1C2zO87zBsqYhlxFrXToZH3hX1pzsFHVc7juB7/uWG32dmj5plW1GbJ3/YN9pT7KGq1K/7PKJAKnSMd9DVQuFGUXbJBK8sPY8TJKv1GKHovg60kT1M6hYW1OIdiiAiJReIn2oniiCqlfPjtOeADrMS1pAfBeyKHMyW4C8jCHPaj6P5OTCjim+9LIE2ONXdLogGwY7hLNcBozQvoLVmhnG6ws0y+jbmXGrZsVHGWEZG51r97BhZIFx4MEUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB5290.namprd15.prod.outlook.com (2603:10b6:a03:426::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 18 Jan
 2023 06:59:03 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 06:59:03 +0000
Message-ID: <b7fcd776-0d32-80d8-89f8-d9b1c05a6dd5@meta.com>
Date:   Tue, 17 Jan 2023 22:59:01 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] selftests/bpf: align kbuild messages to standard
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
References: <20230118-kbuild-alignment-v1-0-eb5e9fd55c92@weissschuh.net>
 <20230118-kbuild-alignment-v1-1-eb5e9fd55c92@weissschuh.net>
 <bc5beea9-0613-640b-b0dd-e54221c2fc06@meta.com>
 <20230118051555.2ud7mrt4tk6q6322@t-8ch.de>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230118051555.2ud7mrt4tk6q6322@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0341.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ0PR15MB5290:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc32419-682a-46b7-161b-08daf9217be5
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qV5NMJIquHN2REGIwK++C0pTAOW1bYBD0al8gR09xDrMlf+KjfAtVmsqbsJciwsCRRbzsM6dk40rsRNJEHVoGozTd0At7tN06lXE2a1jf+Q32I7sfDAoQGEI5hrmY/s5ymJN8ACxEpFO/x8Nc7O2p2ERYXf5jHfvtH9CDGaJOt7KBaZGtUh40p3kheyjQYNCZN9rzOlxUunZnZAM9WUgat8d2vPl0CXx6LDXjZ0dcnBunbj0fHn/sJgHAAnDfz1otRbT9t10HYP4c3mEp2xbeW8Soz5AxTQKqcwAj66zRr60JcsDZoQ8nA5bramYT17R9iUDx/XZaVJASDWFqtrrQxUWqUFS95uLNSFLs5ROmupJNULWuXjl+M62Y0Sz1jPWZL/4F3YX830v++Rt7GyDDIkF3ahVxHU3AC/K532YD6zzVdtx/ww1xKjxhPHk7RyCXvLCJckTidbNjq0PCl7Cklz6ueINfmKmwSEfyaH901QpY9lAEcs01vWa4T/B2+r1W3lQL2ThsTR43igEbdxLxKdcEwAJ8AUkO2lNehPtKonSVg2FEvzjPS05njfgx8bSUQe7sIYuatimsC3xU0my1Ii/w63cDKWpiMRvwqkNjs6NFV5g1pPYYdjlr2A3raAa9ajVAubXf6yLXHoKCJDhFA4ycmMH0KVi2HCnVBS0+Tlk7PNXUiQrKtVtX5TLl9mey9hA4Oz/CyBJ39u/LvqYm5b7LLpn8uRR9FswRlEv46o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199015)(316002)(86362001)(186003)(6512007)(6486002)(5660300002)(478600001)(7416002)(2616005)(8676002)(41300700001)(66574015)(66476007)(31696002)(54906003)(4326008)(66556008)(6916009)(83380400001)(36756003)(8936002)(66946007)(31686004)(15650500001)(53546011)(6506007)(38100700002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c094cEZ6aGxaT0xxd1EyWjZDUDlGM2c5b1VDOS8zNS9oazgzcmVGU3VTTFBQ?=
 =?utf-8?B?NFVLcHU3dU5JempiOGgzR2Q5dmtqTUpYdHJhM3V3dE9DbTlqQ1RvWFNlWkZM?=
 =?utf-8?B?NUQ4WlVyaDdiaDF4S1FGazl4bTZZWTEwZXRtVTJuRnVYb2FuemtIUnNLcWU1?=
 =?utf-8?B?TXdISCtzckVDV0JITkhzY1Y3T2pVQXYySlpiRG5velZiWFlLcWo4a0NOQWU5?=
 =?utf-8?B?a2hEcVdMTEMwb1F3aUxNOUt2QUs1MEhGdTJGNFVjUVVmT3BEcjNkUkJYZnlB?=
 =?utf-8?B?TWhOU211dm1GaGcwc3dzV0tlT3pxNmVBZ2h1V2lmRjZXbHRYYVRYcHlpY1lM?=
 =?utf-8?B?TkNoRVpBczY5NG9haXRrV0tPTVp3N1FPS3NLMlBSSDIxZnZNejR3Z1FBOGZS?=
 =?utf-8?B?V24ybVc0V25BWi9OQjZEMExPUUVmZXRRUTlnRVpPQ1RiZ2NoQ3d4TjBselEy?=
 =?utf-8?B?aHVueFhsc1ZxYUtRR0lkbk1QK3RWMFcramJnblF3MjdhTk5Ea0I1VDllYlBw?=
 =?utf-8?B?SlhuZlNNK2JWelE5QU5JQ0tDa2pMSDhaSW1sS0owTEI5YkZoRldybjhIN3BC?=
 =?utf-8?B?UUpRckRFbXdFQ0V4YjhUbWZZOHJXdWFWOGpVNytVZGpxUU9hUmhTV2ZsNWxp?=
 =?utf-8?B?SnVveE80dHFuK0RhUzQxWGhHSHNURHR2WEQ5YlBuVUI5dEEyTmw0RU5uZnlp?=
 =?utf-8?B?YTZKZHlSR043ZnBGSVVmSk93THFIeklKU2NjVzVEVE1QL3REVW1IdXhLQVBD?=
 =?utf-8?B?NGt4ZnNqZm54RlVkcjdyWHAxM1FoOUI4dFBFdGN1REJUNUxaWlpnc2tycFlh?=
 =?utf-8?B?UVIrTDYrcmZEc1FUdG9XdU1ZeDlNaUh0cXROeVZnQjRkMmEyZi9jNXo5cGJl?=
 =?utf-8?B?cG4zUlBiTEgyNTlXSEJ3eFoyR2xCQmlWdDdFWXYvcGRvamNVK3V0UXFXQnUz?=
 =?utf-8?B?TzV3bjNxQjhxSTVYOHRma1pOVG5CUnQ1dnBLSEE5VDVveW9Hei9JOUFxQVlM?=
 =?utf-8?B?d0puSDh0ODd6SmUwK1lvbVJwd1VlcHp6TTdhcjl1ZlFEWnlWcWJkNFA1VG4y?=
 =?utf-8?B?UVo0eWtWREhOeHJKbFg3YXNmQ3phTDY0U3Rnc2MyUXZLSUdndW9HZmZreG1S?=
 =?utf-8?B?Y1ZYOFpVUkNuWVRrTWM0MGljbkNZeXB5NS9oemp3MTVqUE96Tk0yVFc2SWRH?=
 =?utf-8?B?dTdRZDZrUzZXVHBwK1RlR3dRbGpkeGtmZmVCdkp2WGpCdU9hYVdwUmtQbC9K?=
 =?utf-8?B?R1N6bGo1Zk56UXduWFR6VCtqL0lBSHhNTHhrZy80ZmdXN29oeWp5MTRSa1lC?=
 =?utf-8?B?TkxTeVF3RkdkWWZWN0NJT25Xb2tOb1hiRjRNZzhLOUZKWFRCN2RMZXJPb0xP?=
 =?utf-8?B?bE8zV0xZcWU4bmtZbUZzMXI5M0Mwbi9kdVpEQlVpZys4L0g0OGY4S0FYbzBx?=
 =?utf-8?B?R294MnpwOEhqSkROK21CMFFYeW5WYmlCWXVabGNRTXRVZGF2UVlyb25NMERN?=
 =?utf-8?B?UHdXc2lPNHdmZVVQQW5MMzNqTThwZ1R3cEZpekxWalppUGg0ZWVGQ3pvQlY3?=
 =?utf-8?B?ZnhaNkV3NmlqRDcyanhQMTBQeFl4MnZkWVliMU9RTHRNMzA1U2h3aFo0ZGw4?=
 =?utf-8?B?cWUzRzNyZ0liaGJCdGFGZG14R1JYdDhOOWdTZEtWM043aWdsemxoMlpRaDV3?=
 =?utf-8?B?azl0UW1hekZGcVRIR2pBMWJycWtKenNsYm82aVBsTE1DUzArdytjY2x5NkxO?=
 =?utf-8?B?eTZTVDc0cnR2b1RxU1Q2NzBsRncvaWowUmhSOFpsOHdBemNJcXF3SThtYnJ3?=
 =?utf-8?B?b2xOMlZCSGI3RElKY1NSUjc1VWI1T3NNQlBtTWpPMFg1ZTh5cmNwV1FvTVk5?=
 =?utf-8?B?ZkZTNkZtL1R0MEVSNUs5dnYxR3BSTVFvNk1rczZQME90RnloaVhJejFGQitv?=
 =?utf-8?B?L00yZ2pWT1lCY2V3QldrTVJYM3ZldDAydk13d3FQbW0vQkc4b3BCRWhwRUpT?=
 =?utf-8?B?SGNBVXM5ZnVJajErN0VrN0FtNGhxU0dWV1FYWDl1K1FpQU1JV3ZqcGExaUhP?=
 =?utf-8?B?VnBLbmhOTkpRc3VPNllDUGpLQ2xYMW9nNkh1Ny9HSW5xR3RueE9mcDNHOHd0?=
 =?utf-8?B?aFhEZ0xPdmZsaUQ1aWY2N2htZ0VUaU5jeXp3VWFsRm8xSDZBTHg4WWkxK2hW?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc32419-682a-46b7-161b-08daf9217be5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 06:59:03.5913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+0iBwArRxeZkSclxcKs3oHllTFVWMVeN6eLvCp9r9qWewrVlXweT8ob6OI0SlMA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5290
X-Proofpoint-ORIG-GUID: LrT-Dy1-dg_-EEwNmzBsBWz-b8BO0Yll
X-Proofpoint-GUID: LrT-Dy1-dg_-EEwNmzBsBWz-b8BO0Yll
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_02,2023-01-17_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 1/17/23 9:15 PM, Thomas Weißschuh wrote:
> On Tue, Jan 17, 2023 at 09:02:20PM -0800, Yonghong Song wrote:
>>
>>
>> On 1/17/23 7:52 PM, Thomas Weißschuh wrote:
>>> The common layout for kbuild messages is as follows:
>>>
>>> - 2 spaces
>>> - 7 or more characters for the action
>>> - 1 space
>>> - name of the file being built/generated
>>>
>>> The custom message formatting included an additional space in the action
>>> part, which leads to misalignments with the rest of kbuild.
>>
>> Could you give an example to show the output before/after the patch, and
>> how it leads to mis-alignment and why it is a problem?
> 
> Before:
> 
>    LD      .../linux/tools/bpf/resolve_btfids/resolve_btfids-in.o
>    LINK     resolve_btfids
>    CHK     kernel/kheaders_data.tar.xz
> 
> After:
> 
>    LD      .../linux/tools/bpf/resolve_btfids/resolve_btfids-in.o
>    LINK    resolve_btfids
>    CHK     kernel/kheaders_data.tar.xz
> 
> The line starting with "LINK" has the filename "resolve_btfids" one
> space character more to the right than the other lines.

Thanks! I would be great if you can put the details about
   (1) what are the command line to reproduce the issue, and
   (2) what the output differences,
to the commit message in all three patches.

> 
> It's slightly confusing when scanning the build logs.
> 
>>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>>> ---
>>>    tools/testing/selftests/bpf/Makefile | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>>> index c22c43bbee19..5190c19295d4 100644
>>> --- a/tools/testing/selftests/bpf/Makefile
>>> +++ b/tools/testing/selftests/bpf/Makefile
>>> @@ -98,7 +98,7 @@ Q =
>>>    msg =
>>>    else
>>>    Q = @
>>> -msg = @printf '  %-8s%s %s%s\n' "$(1)" "$(if $(2), [$(2)])" "$(notdir $(3))" "$(if $(4), $(4))";
>>> +msg = @printf '  %-7s%s %s%s\n' "$(1)" "$(if $(2), [$(2)])" "$(notdir $(3))" "$(if $(4), $(4))";
>>>    MAKEFLAGS += --no-print-directory
>>>    submake_extras := feature_display=0
>>>    endif
>>>
