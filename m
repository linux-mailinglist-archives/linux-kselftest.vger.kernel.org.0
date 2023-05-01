Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102F26F34F7
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 May 2023 19:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjEARUu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 May 2023 13:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjEARUt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 May 2023 13:20:49 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC8D170D;
        Mon,  1 May 2023 10:20:48 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 341FhnJc008300;
        Mon, 1 May 2023 10:20:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=JAjhAod+wCoeUIMfIirT0QHdjb+YEiXbgv5EFmT+T1U=;
 b=YDy8athUS3KEPP1GeNQJaY6ds36CSOUAZHt1Gki6wU92DYhI3iIl6oKBKP2dmIUsVYQ5
 ZXxU9GyaZMbXQxgfq9TTpZMijw9gD53F26nWrucSwN3oWhOxU9zrZQ+CORuH3ZnjHLCy
 TSuQdYT0WJhf3HR/+zSjxkYnN23YD/mMKcYjfTohdfBhWM9UzG1P6mtAN7Keq9fFaltU
 rLi+KZZ+o86SVrbrTORShbZTJ9dhXl+vytbjQwn/Nu8EzvZ+IXN6LQT3pRLWutO8uDI2
 mI2tkEU0GRzWiVyhuB9XZAdxfacZhIcypszZFxfajqRlsYQw85BNzp3nQhfohw6jfZyu Bw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qac0g2cfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 May 2023 10:20:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQ39O+hkd6XWPFfDZMdKshAaiJOipIzE8SfOnCcAAQwjaXVST8SKRqkn1jP+Vb2eQzL9WcJMzaUALcpeiBPh+UwOvAJpfHU9OhgqY2+ydHEyWOx4rT7dWd5Xo7X/yoWUYGvjuCn5s/jM0WvhPaABbkifJStKVi7JTInNpylvc/RpIn0rorq+W8KnklQX3oITl20mxfIGCY1DvgSNlA2yisqCsYF3ntPzi5QBirgfLDmxga4y53rqijhBNVcRikvtnbI8xjPvHqn73W/nTIWAlVFrfQ+X56DFRNzpmVrp6gA/2UEoN/zZPpAvwVF3O5an0SPSaSi1d34Fjdq3WGn9mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAjhAod+wCoeUIMfIirT0QHdjb+YEiXbgv5EFmT+T1U=;
 b=cZ2+pNguuQgKgQ7dgHuS8NAwodBOLNVjOc+q3GzEzkRR4ZhskmBA9uT9r102/fZmrM6VMMgrrpPn9i4jF/h+DNY0mQ+3NAnuTRckPCD/gTDXalQlzKDtVjxthIjcPILoOiV0lvS55ORaYk75IIjKSzbmG5fUjTnIW9Holxxd1xhNHGPDkN2qJCscV+PFna565TmlXB3wQ9RKdrxmNVn4GHQWUlpIBZlfiUg1e4785Kyc8wva++OHdNcDKX5599d6nsTUog0P2kpL6IzMGmCIkOAn8K9pwMkejAOHVtjbFLizSCuBabQO6xnM5vdk2VwSWDVaN3teb9qhQWo0OznXoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by IA0PR15MB5791.namprd15.prod.outlook.com (2603:10b6:208:406::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 17:20:24 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 17:20:24 +0000
Message-ID: <e9212ccf-b02d-c2d0-f45f-a94ec2b82c5b@meta.com>
Date:   Mon, 1 May 2023 10:20:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v2] libbpf: Improve version handling when attaching uprobe
Content-Language: en-US
To:     Espen Grindhaug <espen.grindhaug@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <ZEV/EzOM+TJomP66@eg>
 <07e05c57-feb7-5482-9c07-eb41f976f9fd@meta.com> <ZErK0M/qAi/VS8U8@eg>
 <0e7b884a-05c3-83c7-0de1-9bfe14ff77b3@meta.com> <ZE+4Ct7ZMecFy7YV@eg>
 <533437a4-a76d-96e0-b04a-ab8eb7b5fb7f@meta.com> <ZE/pIM/z7x+35KQo@eg>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <ZE/pIM/z7x+35KQo@eg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0109.namprd07.prod.outlook.com
 (2603:10b6:510:4::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|IA0PR15MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: 273e0839-4d39-4606-7689-08db4a6859ca
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NKC8dVAtbIUvtXf+GUhmVMnazwtsROoxnNpWMFX9S/FieDoaFVhNpq9OId3TrMIcJXgtdrOIasjveHZt45pPN0O847dn0x5aYuNfsHalDlhK9NutknrPnzVKqDRx3orxua/34fA4pHt/0DYqfXAwnQcVRaDWak0DwZKnGN9qRKetpTFygk7rZC5ZpUsqm+TdstRoMLRqb9OaKnWklWRBlz8nrcvl4KKYSzz5Peas0Fn2sXx0JT2SSqUkEXly9yInm19o+caVTgFfrVD6oylpOmOtxduRYS6O6VWh+a6RfKTO7pSogZ3i6uQEXddCqTpoJUasMZW7Ifl9gAz4yu/L+g146y1gdcKnp7Nlqjce2RGbBiNfEsHHyiPetZPwCidigHg8LGOnZm19w7fOweQcedeRGKmpafcnMp4BU9Vls8FBcq8B9YTZBUE8a3i31C7Ql9WkM8txMCQvSar9veB4WHvxQlpGRN71HCKv9J6Tp+CBxAh6hAnUocWq+nhT9Mzv/BWa/rfLyIcbW1VXS9gSiQslLpqaOHTlA72ItwJXH6onvknSD1GVCmhlQeYllGW0IE9w2C+v48O2SxbhB9fgskiRu06sfEzbq7wJEfMpcRFyUnnQCcIGg1qPmXSduz0kjIPlBfsBinWyM3/3PomtNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199021)(31686004)(316002)(53546011)(6512007)(6506007)(8936002)(7416002)(5660300002)(8676002)(31696002)(86362001)(478600001)(186003)(66476007)(66556008)(66946007)(41300700001)(2616005)(83380400001)(54906003)(38100700002)(36756003)(2906002)(6666004)(6486002)(4326008)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3ZiUVVQZ1gyNWxGYmxjRytnSEx6TVpHNStLd09pRWdIWENhdXkzSkR6OUdH?=
 =?utf-8?B?cXA4TCtseWxPWEc5T2pVdGVXUGdRWlFtT3FqcHhiaEYyYVFscnBNTHJCNk8r?=
 =?utf-8?B?SEFNZ2IraXFjOE1IQkQxSWtEYjRPaE1wSVE1QjFpWUJleFY1ajVjakxrNktK?=
 =?utf-8?B?WURUZDB5V2I0TVRKODg3OUtoaDlUazNFTDhLZmVjd3BPSVJ1V3lkcVAvVkJi?=
 =?utf-8?B?bXJwWlZjdml0SmN2aVFWdXVWZlJjOFROejBhNU0vb2M4Y1JGWVYvTTdHVDhw?=
 =?utf-8?B?Y0FqU3hDVXVLNU5NWit3ZlZycTJnakZTTGRLVXEzYVEwVWZkYW9pTy9PYVkr?=
 =?utf-8?B?aStYYytwQVlVQkxuVk9zZUJDVmh3azNRU2NMSDh1ekE2c1VudWJwWjNxcTVF?=
 =?utf-8?B?U09sMjkvRDFaYXVVTk9HSXJGMWVvd0VaaGx1bkRBVG5BdmtteHZWNUcxUWxJ?=
 =?utf-8?B?RzFTUUpXcmxMTVVhQThkM3VNVkI5RWpOT1VNYm5PUWF1ZnZkUkpHQVc5aUdt?=
 =?utf-8?B?OW5HcnQ1ZmpSQnpwbXZPZVRPVWhBVGtUSmdqWnhzWVYzcEVpbW5tZ1ZQbkJZ?=
 =?utf-8?B?ZUE4andQVmhvT0hOMUVDeHNSK2IzMTVoOVRPOW5zN0orMUZSVVdKaHJxczAz?=
 =?utf-8?B?VHAyejhCbjBZdExwR0l3L3hha2tYOWJ2RnBWOHZLeDJZTkJIc2pSVnRYbndR?=
 =?utf-8?B?QkF4d3B1Nk1xMnpuMDBCTTFyekFvNjFIeWF5Sy9hRDNJWVZTdmMzUFNNdXdw?=
 =?utf-8?B?U21iKzlkb1NHQlpHamtiWFFPampQTjZSM0l5WStPQ1g0T0RHenZ1N0ZmNlVp?=
 =?utf-8?B?SnZBKzZLTk1yaTlEZ2Vkb2ROTER4Yy9veXdLQmthTEdLem91V1B4NVVyS2Rv?=
 =?utf-8?B?b3NWNVl4T1lFQUw5dWlEMTZkczBUeTA0NTN0TzkvSjZMZ1JSKzQ5UUVDMlJm?=
 =?utf-8?B?a0FQN1Bkc3FXNHdrb21jRGs1UDF1d2lETzRXa0VMM0dvMGpPZ2xrOUZ0TUZT?=
 =?utf-8?B?MG84bGxQQ01KZkdwTmdiNUVQcVlDb2Y0VUl4bGYrZlJSVUhHV0tjRm1pNjMv?=
 =?utf-8?B?OWVTd2pIa2xjUnRTdFl6SXh6Z3lkRUVEYlJLZlhxSHZ1c1FXT1NWdjJ2dUZX?=
 =?utf-8?B?ZndOcXVmYzhKZGg2UzhkVmlENk5wTW5YRlc0RTJ1Q0NYamVhQWd6VWxBVVNF?=
 =?utf-8?B?UWozc3RrNXhrV0MrbURObUFmMlM1Wlh1ODdmc2JaZDN6cnZPQitiN2dDUzhl?=
 =?utf-8?B?TS9oZENLZ3IzSmd3TkdCZ1RoSitWenhrQno4SlhHZDR2OExXVjVXRC90N0xz?=
 =?utf-8?B?ZlBEQkZGVTh5MDR6N2I4dnJ0ZEpMbFdRRlJsOFFpYkJPMWZhQWFzSWtxTmZ3?=
 =?utf-8?B?UEFjUjB6QmROamN1WDl4ZDBIY0dBSm1tZDhsSVNqOW9hb1FDdTdoOFdmTEdF?=
 =?utf-8?B?SEZmYnJXWlhjYTBBMWtuUHJSTW5oTHpnZXBIYVI2cWhOSXVZM0xlbmRibkVm?=
 =?utf-8?B?M2NHQUxXTW02SzJObk9mMUZuR1VjdGliRk5NOXA0U1ZBYlpVRnMrbkxrTmVq?=
 =?utf-8?B?K1ZlbUNjcndXNkR6enEwOEZiMGQyZ0FOSTZHaFhFVnZ5WEVsQ1c1MU94emhJ?=
 =?utf-8?B?TnNBRmtXSWpkSDdKaC9SV045aU4zTDdzalc5RXZNckpyZ0EvbjB0VWxZU240?=
 =?utf-8?B?bEZIcDNUU1hxTzN0V1hia0hpb1BrcFNQcmVCRW11OXpnRmlGZGl2b3BNdGZ1?=
 =?utf-8?B?UzFXcTVzcW1DM2M4cVV1cjE1dDVrOTYrekRJSXljL3A5cnhMNjFYUHliRFRM?=
 =?utf-8?B?SlkrcDI3d01zbFV2THVSazh3TnNMdjRGWVlBbEZETlFwUTJWdVNWZmlJTjhG?=
 =?utf-8?B?cTd3aXkvZzhTbDlJRCswaFQrT00zUG5td2Y2Z1ltdng1M1NFMDE1c2VsT1lH?=
 =?utf-8?B?MUVreXFEalRVemkrbnFNMjNqQTFRS0NKamlkeS9saVBrWXZGUU5qNXpRSTN3?=
 =?utf-8?B?UjhvaU0wTXB2RVpSclRUZ3N2VXpoNUUrbGczYUhzbEkrQSt5Z1RwR2hZaXBT?=
 =?utf-8?B?TWluYUZ6dk9Cbmo3eVUwRmJDT011M1NJUSs2T3piR1FQL3pKR1FTMEVTV21m?=
 =?utf-8?B?Rjh1Tm1ka0swY3luTTFscEdTanBZN2s4a2lnN0JYT1dGVVR4cTdTaFRpeTh6?=
 =?utf-8?B?S1E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273e0839-4d39-4606-7689-08db4a6859ca
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 17:20:24.7812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wcgd9VAIdS90cg3BDAlRgD116NN1H8zL/WSgaIM2CnNs6joS8/l17/ZoxmVcqPcv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR15MB5791
X-Proofpoint-GUID: BDcqKu4TmLl4tdEnq9FZWvtqfqoQ8YAg
X-Proofpoint-ORIG-GUID: BDcqKu4TmLl4tdEnq9FZWvtqfqoQ8YAg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_10,2023-04-27_01,2023-02-09_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 5/1/23 9:30 AM, Espen Grindhaug wrote:
> On Mon, May 01, 2023 at 08:23:35AM -0700, Yonghong Song wrote:
>>
>>
>> On 5/1/23 6:00 AM, Espen Grindhaug wrote:
>>> On Thu, Apr 27, 2023 at 06:19:29PM -0700, Yonghong Song wrote:
>>>>
>>>>
>>>> On 4/27/23 12:19 PM, Espen Grindhaug wrote:
>>>>> On Wed, Apr 26, 2023 at 02:47:27PM -0700, Yonghong Song wrote:
>>>>>>
>>>>>>
>>>>>> On 4/23/23 11:55 AM, Espen Grindhaug wrote:
>>>>>>> This change fixes the handling of versions in elf_find_func_offset.
>>>>>>> In the previous implementation, we incorrectly assumed that the
>>>>>>
>>>>>> Could you give more explanation/example in the commit message
>>>>>> what does 'incorrectly' mean here? In which situations the
>>>>>> current libbpf implementation will not be correct?
>>>>>>
>>>>>
>>>>> How about something like this?
>>>>>
>>>>>
>>>>> libbpf: Improve version handling when attaching uprobe
>>>>>
>>>>> This change fixes the handling of versions in elf_find_func_offset.
>>>>>
>>>>> For example, let's assume we are trying to attach an uprobe to pthread_create in
>>>>> glibc. Prior to this commit, it would fail with an error message saying 'elf:
>>>>> ambiguous match [...]', this is because there are two entries in the symbol
>>>>> table with that name.
>>>>>
>>>>> $ nm -D /lib/x86_64-linux-gnu/libc.so.6 | grep pthread_create
>>>>> 0000000000094cc0 T pthread_create@GLIBC_2.2.5
>>>>> 0000000000094cc0 T pthread_create@@GLIBC_2.34
>>>>>
>>>>> So we go ahead and modify our code to attach to 'pthread_create@@GLIBC_2.34',
>>>>> and this also fails, but this time with the error 'elf: failed to find symbol
>>>>> [...]'. This fails because we incorrectly assumed that the version information
>>>>> would be present in the string found in the string table, but there is only the
>>>>> string 'pthread_create'.
>>>>
>>>> I tried one example with my centos8 libpthread library.
>>>>
>>>> $ llvm-readelf -s /lib64/libc-2.28.so | grep pthread_cond_signal
>>>>       39: 0000000000095f70    43 FUNC    GLOBAL DEFAULT    14
>>>> pthread_cond_signal@@GLIBC_2.3.2
>>>>       40: 0000000000096250    43 FUNC    GLOBAL DEFAULT    14
>>>> pthread_cond_signal@GLIBC_2.2.5
>>>>     3160: 0000000000096250    43 FUNC    LOCAL  DEFAULT    14
>>>> __pthread_cond_signal_2_0
>>>>     3589: 0000000000095f70    43 FUNC    LOCAL  DEFAULT    14
>>>> __pthread_cond_signal
>>>>     5522: 0000000000095f70    43 FUNC    GLOBAL DEFAULT    14
>>>> pthread_cond_signal@@GLIBC_2.3.2
>>>>     5545: 0000000000096250    43 FUNC    GLOBAL DEFAULT    14
>>>> pthread_cond_signal@GLIBC_2.2.5
>>>> $ nm -D /lib64/libc-2.28.so | grep pthread_cond_signal
>>>> 0000000000095f70 T pthread_cond_signal@@GLIBC_2.3.2
>>>> 0000000000096250 T pthread_cond_signal@GLIBC_2.2.5
>>>> $
>>>>
>>>> Note that two pthread_cond_signal functions have different addresses,
>>>> which is expected as they implemented for different versions.
>>>>
>>>> But in your case,
>>>>> $ nm -D /lib/x86_64-linux-gnu/libc.so.6 | grep pthread_create
>>>>> 0000000000094cc0 T pthread_create@GLIBC_2.2.5
>>>>> 0000000000094cc0 T pthread_create@@GLIBC_2.34
>>>>
>>>> Two functions have the same address which is very weird and I suspect
>>>> some issues here at least needs some investigation.
>>>>
>>>
>>> I am no expert on this, but as far as I can tell, this is normal,
>>> although much more common on my Ubuntu machine than my Fedora machine.
>>>
>>> Script to find duplicates:
>>>
>>> nm -D /usr/lib64/libc-2.33.so | awk '
>>> {
>>>       addr = $1;
>>>       symbol = $3;
>>>       sub(/[@].*$/, "", symbol);
>>>
>>>       if (addr == prev_addr && symbol == prev_symbol) {
>>>           if (prev_symbol_printed == 0) {
>>>               print prev_line;
>>>               prev_symbol_printed = 1;
>>>           }
>>>           print;
>>>       } else {
>>>           prev_symbol_printed = 0;
>>>       }
>>>       prev_addr = addr;
>>>       prev_symbol = symbol;
>>>       prev_line = $0;
>>> }'
>>>
>>>
>>>> Second, for the symbol table, the following is ELF encoding,
>>>>
>>>> typedef struct {
>>>>           Elf64_Word      st_name;
>>>>           unsigned char   st_info;
>>>>           unsigned char   st_other;
>>>>           Elf64_Half      st_shndx;
>>>>           Elf64_Addr      st_value;
>>>>           Elf64_Xword     st_size;
>>>> } Elf64_Sym;
>>>>
>>>> where
>>>> st_name
>>>>
>>>>       An index into the object file's symbol string table, which holds the
>>>> character representations of the symbol names. If the value is nonzero, the
>>>> value represents a string table index that gives the symbol name. Otherwise,
>>>> the symbol table entry has no name.
>>>>
>>>> So, the function name (including @..., @@...) should be in string table
>>>> which is the same for the above two pthread_cond_signal symbols.
>>>>
>>>> I think it is worthwhile to debug why in your situation
>>>> pthread_create@GLIBC_2.2.5 and pthread_create@@GLIBC_2.34 do not
>>>> have them in the string table.
>>>>
>>>
>>> I think you are mistaken here; the strings in the strings table don't contain
>>> the version. Take a look at this partial dump of the strings table.
>>>
>>> 	$ readelf -W -p .dynstr /usr/lib64/libc-2.33.so
>>>
>>> 	String dump of section '.dynstr':
>>> 		[     1]  xdrmem_create
>>> 		[     f]  __wctomb_chk
>>> 		[    1c]  getmntent
>>> 		[    26]  __freelocale
>>> 		[    33]  __rawmemchr
>>> 		[    3f]  _IO_vsprintf
>>> 		[    4c]  getutent
>>> 		[    55]  __file_change_detection_for_path
>>> 	(...)
>>> 		[  350e]  memrchr
>>> 		[  3516]  pthread_cond_signal
>>> 		[  352a]  __close
>>> 	(...)
>>> 		[  61b6]  GLIBC_2.2.5
>>> 		[  61c2]  GLIBC_2.2.6
>>> 		[  61ce]  GLIBC_2.3
>>> 		[  61d8]  GLIBC_2.3.2
>>> 		[  61e4]  GLIBC_2.3.3
>>>
>>> As you can see, the strings have no versions, and the version strings
>>> themselves are also in this table as entries at the end of the table.
>>
>> I see you search .dynstr section. Do you think whether we should
>> search .strtab instead since it contains versioned symbols?
>>
> 
> I searched .dynstr since my libc files only have that section, but I do see
> your point. If const char *binary_path points to an executable and not an
> .so file, then we would find some versioned symbols in the .strtab section.
> However, since libbpf supports using the .so as binary_path, would we not
> need the functionality to build the complete name regardless?

Okay, so you do not have .strtab section, the section probably removed
with `llvm-strip --strip-all <binary>`. In this particular case, I think
your approach to search SHT_GNU_versym and SHT_GNU_verdef for versioned
symbols probably is the right choice. Please do add such information
in the commit message.

> 
> Adding a check to not build the full name if it already contains an '@' is
> probably a good idea, though.

If you search strtab, you will find name with '@', but this won't be the 
case if you using SHT_GNU_versym/SHT_GNU_verdef. Since both dynstr and 
strtab are searched, I guess adding this check is a good idea if the 
version in strtab case is not NULL.

> 
>>>
>>>>>
>>>>> This patch reworks how we compare the symbol name provided by the user if it is
>>>>> qualified with a version (using @ or @@). We now look up the correct version
>>>>> string in the version symbol table before constructing the full name, as also
>>>>> done above by nm, before comparing.
>>>>>
>>>>>>> version information would be present in the string found in the
>>>>>>> string table.
>>>>>>>
>>>>>>> We now look up the correct version string in the version symbol
>>>>>>> table before constructing the full name and then comparing.
>>>>>>>
>>>>>>> This patch adds support for both name@version and name@@version to
>>>>>>> match output of the various elf parsers.
>>>>>>>
>>>>>>> Signed-off-by: Espen Grindhaug <espen.grindhaug@gmail.com>
>>>>>>
>>>>>> [...]
