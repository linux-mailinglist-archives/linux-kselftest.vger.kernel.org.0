Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A4263299B
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Nov 2022 17:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiKUQeN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Nov 2022 11:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiKUQeI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Nov 2022 11:34:08 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D155F874;
        Mon, 21 Nov 2022 08:34:08 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALFp1ua029292;
        Mon, 21 Nov 2022 16:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7ndCCdbE+/C7dW1g55oFBsakDi5rQPz06m9rzxSrteQ=;
 b=NhMkrAYvIA/pJdGR/JFjN+BzCFE4xTO/oBDC9XWcgrhkBbwUYJINCt1dvtZWKgEAmsos
 fMBoPzkDbtNm6jJMD7wK0c1cm6B1MArxleogRqDptdJGXsCjgKXKjTF8iqAPFBw5Jh2r
 Ux+dgnu2Nyqqk+tKqUQFWHZZROTg5ygTIMyB8dcUu60LNBsBsfFNLxBfRXVLHuwYUDFf
 BV3zZ8WF9Uf/CLlBpJNVbWP3fLITfW3QMaO8GM9iJibrlNbIxYr0oXa/NHgk1TNSwssY
 zFjbB8xxJI1VT6MTR7ZzpkMtGnFPkztUVuwifgDKAvtaOoPeHoRXlbkeDBYEydbtXHZy sw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxs57n9dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 16:33:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ALFgej1029038;
        Mon, 21 Nov 2022 16:33:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk9r1yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 16:33:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bz/FXMwIn6NGbbQE5XKjbEONYYQzGbgBpLq/czovQVUM02CERs2FsWC2KzScWGcDEbopfLnS1dT5NuMU7PMbEecpv7PYcfuTrzpfnOeu4wiTJme+33yXzciQcG5o/zRpK5BNGlCMtZOm1Xmn+hjfHQbSaofbBYG+bWa4MJzDt245SEzYtKV0E65pP5JKfwQNBjMSEjiG0lGMISz3L+ZokMbMyx+R23ySUHgb0W6+hptRMWNrUWBv28AaO8ei6lz89on+eN4orHwDoWNcGMehYAwRdXiCVhtEJvODRIXAEomR+MDZnZ0S1kLg8xZQEGj+bPcnE/2mP//TXIax4bRQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ndCCdbE+/C7dW1g55oFBsakDi5rQPz06m9rzxSrteQ=;
 b=EL4qS9HvkY2tqKvEvzbbFpz8FVm9XvrkqN+cFSSkzGCRJTiRrIPlZyAMFFUktVAUm7d8DY2acBCM7tNYUVWvFv0zSv+BvgedgpWXPty6NRLTqNDSAllnOjZe0J35zJigdQpq7n/3LpP3z6LqZfWBtilgX91R30F/fcD+3Ymbrqo7oyeSpJYeV3fvoE15jwDHDAMluSFBn9HIkJZb9lBodmZIxbOA1mqxO7v0OSqcULLFmTBBJ7MVIbDpS3stRjeT3PJ4TFEe+kazchDso0MTKeGzqLtEvlKQJNyV0WwQ3aFZ1SfPo7uxSKLmJzVkTEKT8s0x77EtsfUfBzfkH83CIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ndCCdbE+/C7dW1g55oFBsakDi5rQPz06m9rzxSrteQ=;
 b=psGtE1UvnuYWY21j/zyS9NM4W7x1xqzUu+OctNxDewAm8S77S05RPP2+ngctlsvx2G3krdOjyo3H/lyooIO64UoREWMMBx6LXIpWSRjzMD0pYnqRl1o0VcWLEaQtEriW4/mS094L2JCo0I85y71YR7shvq7HMdu1NgX0HxvmRvU=
Received: from BN0PR10MB5030.namprd10.prod.outlook.com (2603:10b6:408:12a::18)
 by SA2PR10MB4714.namprd10.prod.outlook.com (2603:10b6:806:111::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 16:33:48 +0000
Received: from BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::c13d:dad:6a35:b25a]) by BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::c13d:dad:6a35:b25a%7]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 16:33:48 +0000
Message-ID: <ecaf1315-5880-9286-2f0b-93135a0cc7c8@oracle.com>
Date:   Mon, 21 Nov 2022 16:33:41 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
From:   Liam Merwick <liam.merwick@oracle.com>
Subject: Re: [PATCH v2 7/9] KVM: x86: allow L1 to not intercept triple fault
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        Yang Zhong <yang.zhong@intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Colton Lewis <coltonlewis@google.com>,
        Borislav Petkov <bp@alien8.de>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kselftest@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Wei Wang <wei.w.wang@intel.com>,
        David Matlack <dmatlack@google.com>,
        Liam Merwick <liam.merwick@oracle.com>
References: <20221103141351.50662-1-mlevitsk@redhat.com>
 <20221103141351.50662-8-mlevitsk@redhat.com>
Content-Language: en-US
In-Reply-To: <20221103141351.50662-8-mlevitsk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0291.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::8) To BN0PR10MB5030.namprd10.prod.outlook.com
 (2603:10b6:408:12a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5030:EE_|SA2PR10MB4714:EE_
X-MS-Office365-Filtering-Correlation-Id: e7236731-33bd-4db8-5624-08dacbde2a94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VSvGl/ND2Eh2xTpPslwHR+N5XZhO6DF8gCSeMHRu/z5eKa04hEiVa22VMfjAlW8988ojY+qWyTGd2g/ptvMLhhCFy8MsbUVnosaxm7W50vAwr/hDfY5D2KlPWwvAuXeKZ7HVn7cIWjFTfXFrO6HMlgDGvEL6VL2Pt3XJjxkI66/9KnJqYP8v2m2WcesjGkvbW0/urwem2CvD6HnSQBB2EnK+qhIc1IL45CvlSFO1tvciWx9JmP1dzrYNGOf8S8IHm3WSSn3x6w24EZ77pum/D1q4BhmCzbe8/M1ruRaeEU37qvPfxJxVbTrsJBj1cKwA60bveRWLMwMw55JU1JcMzumPu3reDDP5D2CiB5KNUbC7CSjRhHZBVuL+EZ8Ygg/se+vtxqGMy8lxun7d3Reon0ykGYz+5P1Ejkl1iNwbLf+dNkcwtJOMPesATiFUp1t1VCkLAWujlgpSzg8j2kzqEo2pwoKIzBo8exXwFgNo/PCsuhraRXsiT5ncppar2hTM/3mUO1icOe9N/iGohskmAaZN174kbWeQfuwNxRipfaQk3gFFio9NY63eiySdtlrFfMHiLfHIC20vRnHzzQ13bWn3tvWRhZN6Zvu11SM1ShLj8Izi4fS2Ba7trM7PIB5+CAKvUCm3tDC5x7+qLh6O61dR8v7SoLOtA8NNWzGwLZtXnHkexGdGjPRTYQgTR5kErpbe8qJrJamhnCOO+PivRaJ9lXQs//+MwlLfx/9JAQw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5030.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199015)(2906002)(31686004)(6506007)(2616005)(66946007)(66556008)(41300700001)(36756003)(31696002)(86362001)(54906003)(38100700002)(83380400001)(53546011)(4326008)(186003)(8936002)(7416002)(44832011)(66476007)(8676002)(5660300002)(107886003)(26005)(6512007)(478600001)(316002)(6666004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVJySUFMYkJsSVlKSFBHOHEyREE5bi9MekN2LzU1NGtXMTFadVZ5Y1FZQkpR?=
 =?utf-8?B?cjNpK2s1SmJVNGYrSmRMMEg4SjBTcGFwNHprV3diaTNZN0MwZ2M3dEJxNmdw?=
 =?utf-8?B?MHBzTzQ2dFc3OGhISTlNeG9WOG5wdU92RkJjUUxueVlCWVRneTFmSFU1RStN?=
 =?utf-8?B?Q2NCVk9JUWRGMnNKQi85VXZqZkpLU0xIZlZ4c1M4STdFUEJ2TVRjdnByWi92?=
 =?utf-8?B?UmZPckNta2hzUnpRMEdSQzh5cUtacUJFamM5cGN2UllnQThTMHMwWGl6THhu?=
 =?utf-8?B?cm1iaytDSVFaSU1VSUZMdm9hWXBDdEFSRnVTeHhOZktiMk9BcUxVV2lKMXFq?=
 =?utf-8?B?bUZBNURjRVRPdkJZM1JEMjk3VFBQaVdWM0lzY3drU3h3NFl4Vkl0Qm1hYVNx?=
 =?utf-8?B?ekYwQmduTW9tUmp1dFpOWTJmaCtiT2tTU2VFUjlvQ1hKSDhnak9CN0NaeDFk?=
 =?utf-8?B?TStmYmFFN202UVd3QXprY2J3dGUwUmJWNlJzNkczNlRyNXFpYXNvS2Z2d1dU?=
 =?utf-8?B?ZE10RU9VZW9sNXVpTXhFbXNMRENjdDAyRGduYmRwcW5zb1Y5d0lSL2xOQXpy?=
 =?utf-8?B?dndpZ1lIL29CMDFiZXlaN3RhekFlbC85ZjUwa05ZRXh6YTJuNHZLZmRPUHBm?=
 =?utf-8?B?ZVFYSWpmRjZLYzJLUEdDT3F1WTBhY2ZCVnhOQmhSNnBRci9ZTVpHMzJYd1Aw?=
 =?utf-8?B?akQ0alR4d3k0SWlWQ1E2c3JzT2xsUE90bkxJc1p2Z1YzdkpzWXhSa09mcStz?=
 =?utf-8?B?N0w2MmNvTEU5Nkh2TnUvQUFaZk5MRWgySjNPZjNNbHA5Mk84RjljY2FBclhJ?=
 =?utf-8?B?Z3pUU3p6dFdCakhHRWo1SS9HeFMvSnNldE1nNWxLd2FlTy9obzBLUlk4ZHNj?=
 =?utf-8?B?UTM3ZmRWSVcyR05NNGc1SFpvaFdmU1lTZFNlNEtpL2IvZ3JDZlZ3N0dtcHYv?=
 =?utf-8?B?ZW5UdU5OeXpTcC9DODMxUXphU1MrYW1jMU9oWDRqdjliQ2trRE1vaXNmVi83?=
 =?utf-8?B?MnVPRzMvR2R2djQ4Ukx6Q0FkY0FyTTI1WWo3Y25wRm9HWmgvNHFkcFFBZy9h?=
 =?utf-8?B?T2Q1WVFPUzBaZnVSa0U0OE9qVW9keEhwdXVBV1dmeExqclZTY1pUT0hDeHdG?=
 =?utf-8?B?bGdaRlhOZEV4bHhsKzNnSW8rWnEwdHduTURrMTBIbElUQ205QzcwMU5pME44?=
 =?utf-8?B?S1ZGMDRJY2dhcDVTWGY0OEZ4bnhseWZBMEQ4amF5a3pQcEladkkyWnlvOGFl?=
 =?utf-8?B?cUFldjFQNnVoT1Bia3IrSXMySGJhMXRBRUFOYmRGemUxaDhMODdmMTB0L3M5?=
 =?utf-8?B?enZRQjh2dTgrY25nUmU0RFI3MzRUd1NOb1piY0ZXM3p2aC9QUFp4eGtFak94?=
 =?utf-8?B?NUFCT3N5bmdnU1lvL3IwTnhoSXF5OTZ4eGxEV1A2Qm1HTXd6Zm5aZ3hWS3U4?=
 =?utf-8?B?RzBDQVhYVVpLUXJhSktCTkZjdDh2NEtkdXlVU0JnWkNNQS9yeWptSFlMLzFH?=
 =?utf-8?B?citFV3RJaWZacVN4Z2VZQWEzNHpET3FicGRzK0tQN0tuNGg2TTNjWUN2azVq?=
 =?utf-8?B?Qkl6MkV6akNrOFY1UUltcVRlY2IvZEdONHlQVU1yNjhkcVE5elBQUFAvZkto?=
 =?utf-8?B?cy9hNHRveWFoRGpGQmJtQU9YVHM0WlRGYjBNaGRzYTA4eXBnWkx2ZlF1VDFu?=
 =?utf-8?B?Sll3SmN4YjIzdXRFSXNBWGRKQU5wdVI0emovc2FFOHlsVUJ5bElTUVo2RFNC?=
 =?utf-8?B?VXhLSEJOZVBGeXNldE50d0dXUWZBSTN5QjQwY2tEajNWVGgwdzBSRHNBM3dQ?=
 =?utf-8?B?WDkyMGRuWVBhS2tuakFKaWpRc2VtK0JvZDFoZmgzZnRTQms3UmZBZFh5WDRn?=
 =?utf-8?B?Mm9QemZtV1BCNittcW5DTzUwQ1VjQnZOVTZLbzhjbDRBR3l0Y2gzOUVjNTE3?=
 =?utf-8?B?aWszL2t3djdPQW10QjBLTnV4Y05tOUZNNVUwOC9QaU5VUHEwSENBeENzSDIw?=
 =?utf-8?B?Z1VtRVRwdkw1YloybWtEeVpoRmpOcE5jNVFhM2FDTjFKY1NPdDZydVU5Zkha?=
 =?utf-8?B?eHV0YmhRUnEvZnViZXFoMnB5SjE5d0JUTWVLR0xuYzd0MldpL3FuR2VUM3Vy?=
 =?utf-8?Q?rD1ufYbISv02LmhFI/FOkFDAE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NnVxZ3JVM3o2Nmc3SXNIU29YVFVFZ2lMYnYwd29PVEVDWi81TnRicGI0U0sz?=
 =?utf-8?B?WmpwekhRVmk4SXZsQlpoWlNuR3dEblR6aCtBd2NSZ281VlFXd0U2OUZ3SDNF?=
 =?utf-8?B?WUFOZWRPcjhVY01XVTZjMWNmZDVPSnBQWVB0NnRCQ0ZGeE1BNkNlczR6MlI1?=
 =?utf-8?B?WXRWdUpFRWZ2SHhxbTI1elA5U1Z3Zm9pcmh3cjdnTy8yMGc0TlNBVTB3UVJm?=
 =?utf-8?B?U2VIU25rWlYvUFJ5WnRpQVI0OGQ1VUVTVnA3VGpBd0V1N1FtNVdEZy9GKzY2?=
 =?utf-8?B?S2JydFN6Zkw2Q3FmVXJYRFdPSjF1aXVvSDB0WFZHcmhFaE9Cc2xBelVsQ01v?=
 =?utf-8?B?U1lpdktvZFhDRHd3K1AwUU51enhsTTFYajVJQitKVmhYcmFrdTFsbi9OdjJz?=
 =?utf-8?B?RWJqK0RnTjRZVU9QRkZTZWpNZmNON0tFblVkeFNCdDZjOVdBVGJrZ2hjNnl4?=
 =?utf-8?B?MS9IVkZQZGFSS0FOZ1FqY0R5dVNERzRtd0NlcmVIbTBIUEJ5UjArREkwUm9x?=
 =?utf-8?B?Q2gwNUNUWEZnQTdFcEFNUWg4WndnK21ZM2tTRkduaElmRXJmZmVha2xWNml6?=
 =?utf-8?B?cWlWUENYRExpYmJRWmJsVlp4Z2diSG5hRnErSFBqcW96ajdCa2FGbldkK1R6?=
 =?utf-8?B?czJWOSs5cmhCNWU1Z21lQ2xreXpZeUVXVFEzOFRwQWtkSzJoeXQ0VFFWbjR2?=
 =?utf-8?B?R3hjUXlXYWlPSmNXRjQxWGdmN0dXaGJtNExSaXVtWEpPaU5BNnBHWHRSS3U4?=
 =?utf-8?B?ZUhjeDRrTTVVWXozczlqcW9JZjdjbGV4bHhmT2U3OEsvbmlXeGNlc3JDSDRJ?=
 =?utf-8?B?NzNOdjdpd2Z2WVlqL0paMnQrRlFLbTFlVmFONnExelh6Y2JpMWhOc3MyYlJ3?=
 =?utf-8?B?Q3FBWW05aUZ5WmpOOWpZT2w5U2JZdVhDQko5VG9aNmMrc212QmNBNmc2bUZC?=
 =?utf-8?B?cldJRFo3aS9KUEtZUUdocys5S0pmTlN0STBJR1YxdzhjUUlyVUtlUmJZTy8z?=
 =?utf-8?B?dVZhWFNDcndKQUxZOVRjWEZwRnFpMzMzZU9VdElOM1hxWEVCcWl4Z0lGcUhM?=
 =?utf-8?B?VGtkdlJVWlBFTWU3TVlCdjI2Ky9iYy9ObEZCdXdmMnVVVFVORFNSQ2JURDIr?=
 =?utf-8?B?VHZsWU9FbzhyMEVYblRjODNQcFYxNUg2a3NxWHQwblF5Y2RxdURrSWdUdENK?=
 =?utf-8?B?WHowQ2YwU2RFOVk1aVR4c2ZUZjA2UG9tYmJDRGNuQTVrWG9lemdvd2tXT1J3?=
 =?utf-8?B?aTJMQVM5SlZFTEFsbEJOUkFhOVNKOVQySkt2ZFNzVXBtU1dLaFVmUjNaNlVm?=
 =?utf-8?B?SlBIZ2RhNERIMVlNTFBVRmNUTDNRdG85WUlvMFhNYVQ3aHp1TldoWFlrZW5O?=
 =?utf-8?B?VVd2STh4NFFuRWYzVU1NdFVJdjJhQU9yTi9ybzJwWGZkdVZwTGdsU3kyWGx3?=
 =?utf-8?B?L0dCS0tsNHZiTHBndkU4NWdkVExoT3RiNWdESktvOWc2enZrc3pCYmtZQ3Ix?=
 =?utf-8?B?M044K1pqMW8rZ08zVHdNVDZXR0hvVXB5aFpxUjh5eEp3WmR5THBiN1dMOXlK?=
 =?utf-8?B?ekNONHlMbU1lYU8ySVZWa0h1OTM0Zk50WE52eGhtMklmM1RnOUEzOFpiMjNa?=
 =?utf-8?B?YXJRbjN4VXZrR3FXYUF4R3F3aExHT3B3SFpxOW12SzZLallyTGtabDBCNEk5?=
 =?utf-8?B?RmxjK081REVHWVVHM0dGZlN4MGVzc0RROS9waEpIbDlUYlVwb1AvaVA2cHI4?=
 =?utf-8?B?YmNMU3IwcHBIQ1NxcHJMZy90ZXlhL2FqVjd1dDR4dUtMVy9oeHJ4QldDa2tl?=
 =?utf-8?Q?rKV+PuZX9LAzAkgD/F1MM/Ag7ahs6N1YKi1v8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7236731-33bd-4db8-5624-08dacbde2a94
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5030.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 16:33:48.5138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEwVMvm846LC7lenZrxhNAdq3VOaKzX4Wij7R+24MzRQrfM6yY8S11UMKh+/JRuFyUJ0G+/I4/DseNeroMsXTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4714
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_14,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210128
X-Proofpoint-ORIG-GUID: p76gBpN4KULygWpxkNlR6YFAUVsURwnV
X-Proofpoint-GUID: p76gBpN4KULygWpxkNlR6YFAUVsURwnV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 03/11/2022 14:13, Maxim Levitsky wrote:
> This is SVM correctness fix - although a sane L1 would intercept
> SHUTDOWN event, it doesn't have to, so we have to honour this.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   arch/x86/kvm/svm/nested.c |  6 ++++++
>   arch/x86/kvm/vmx/nested.c |  1 +
>   arch/x86/kvm/x86.c        | 11 ++++++-----
>   3 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index bcc4f6620f8aec..3aa9184d1e4ed7 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -1092,6 +1092,12 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
>   
>   static void nested_svm_triple_fault(struct kvm_vcpu *vcpu)
>   {
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +
> +	if (!vmcb12_is_intercept(&svm->nested.ctl, INTERCEPT_SHUTDOWN))
> +		return;
> +
> +	kvm_clear_request(KVM_REQ_TRIPLE_FAULT, vcpu);
>   	nested_svm_simple_vmexit(to_svm(vcpu), SVM_EXIT_SHUTDOWN);

You could replace 'to_svm(vcpu)' with 'svm' here
But LGTM either way.

Reviewed-by: Liam Merwick <liam.merwick@oracle.com>


>   }
>   
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 1ebe141a0a015f..7924dea9367813 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -4855,6 +4855,7 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
>   
>   static void nested_vmx_triple_fault(struct kvm_vcpu *vcpu)
>   {
> +	kvm_clear_request(KVM_REQ_TRIPLE_FAULT, vcpu);
>   	nested_vmx_vmexit(vcpu, EXIT_REASON_TRIPLE_FAULT, 0, 0);
>   }
>   
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 3fd900504e683b..f0a0102a78f5c3 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9741,7 +9741,7 @@ static void update_cr8_intercept(struct kvm_vcpu *vcpu)
>   
>   int kvm_check_nested_events(struct kvm_vcpu *vcpu)
>   {
> -	if (kvm_check_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
> +	if (kvm_test_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
>   		kvm_x86_ops.nested_ops->triple_fault(vcpu);
>   		return 1;
>   	}
> @@ -10255,15 +10255,16 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>   			r = 0;
>   			goto out;
>   		}
> -		if (kvm_check_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
> -			if (is_guest_mode(vcpu)) {
> +		if (kvm_test_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
> +			if (is_guest_mode(vcpu))
>   				kvm_x86_ops.nested_ops->triple_fault(vcpu);
> -			} else {
> +
> +			if (kvm_check_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
>   				vcpu->run->exit_reason = KVM_EXIT_SHUTDOWN;
>   				vcpu->mmio_needed = 0;
>   				r = 0;
> -				goto out;
>   			}
> +			goto out;
>   		}
>   		if (kvm_check_request(KVM_REQ_APF_HALT, vcpu)) {
>   			/* Page is swapped out. Do synthetic halt */

