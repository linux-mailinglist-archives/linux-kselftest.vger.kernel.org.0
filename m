Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E1D747539
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jul 2023 17:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjGDPXG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jul 2023 11:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGDPXF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jul 2023 11:23:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A78CBD;
        Tue,  4 Jul 2023 08:23:04 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 364EiV3l022275;
        Tue, 4 Jul 2023 15:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=L+ZKWyyvL9IhX6G6KgxeJmcz4VgLUZHgsXsJyBfwt+g=;
 b=vnE0ovd35rA5joLYd+LpIlIEOEZN1H9EF7S8tebDYz39iufwWPqwAAuPhDt5wQUWh0QQ
 Px8fFMvzzD7xbvphTloxuJ1BfqzHpSK/n1vXAJUgalMYyycaOT+PlPwBmCp+0JL4FSq5
 zazUeROI5cIllrT1WOxxKV9e73Hn3mgu2YTMpLmCOE1/Qn+fB53b8bpZDTpqLyQ19+z5
 zY5jbdEz7oONv1Jjw5jP/2MSrOOXH/vT6ozRbGiXSts8svO1/FHIVUoEQFUQI/0huBZT
 pi4pAVPolPxdC9k+hcXvbs6ITJo4MkHq4T4RzJhMdeFGNE10ShEa1vrb8rlmuwDTbz4n /w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjc6cmujw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 15:22:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 364EFDG0004182;
        Tue, 4 Jul 2023 15:22:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak50v43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 15:22:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9Ov0JnD4rIofCzL4HJumdzPbejgQxBSqclZMLbsoI7k8sTW7v3S0k6CIoT6Smf+rg3v29FUQvfS0IV8fH2kgKX9Lh/r+aDEUJAv8V9yz/+okaBtshLqcuCYd5ohCJ68vDOMJAX87D/8TxOlWixkSO9ZrAcOXAYOJ9NOpy0n0IbpDxpJFwYHudfGFiZKIeFJlmaGJF6AKNNvyfEuG93stwtwyqiILIlPihjOrZq+JSQPJUAZlGfjkOVdiUavmZFwAKBzD2BVPUSrr3JTr/Qq9Rw7sndy8y+W/EQnoFsgKMJCFJwY0NxVtDlNLfm6DGFGXS+NJJ45F5z3saPXRlj5pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+ZKWyyvL9IhX6G6KgxeJmcz4VgLUZHgsXsJyBfwt+g=;
 b=bVgIe2klwoPI6EDRFCBK002oBO1vExn5Qwzzgbp95l676/BLMcceZeDXT0OfjAHtsHWv9ZRQRAvvsYWpfn67B6M12P67QAHBxWKJxC20xnRbnncTShJOq1MVyUTR/V7ZU22sNJRJSCV5xJ2UsscwTUtIA3XRSkIpEWLUAzFrfwjKaQ7321ely/YVXDnjqtiWSjd6TqmYGg2p1lTzAV6HDkOBE5VnOByx++41LWRvWQROXZeUoqIIDLyR3dghX0965JyC++z9eqz0G8UVAHE9XCRbyXiVdtVKFsmGeHs4TWG078XhmXKMnyGp6Nyf0BlqhvfAv/5ERXNC15wkyAEcjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+ZKWyyvL9IhX6G6KgxeJmcz4VgLUZHgsXsJyBfwt+g=;
 b=cHxPe+Ax82ye9jK9IxE8eO5u8wKYo1goHLL+irjKK1IdoC/t5AxCHv5CVaAKDdUiutQ7zuCHonrtfJyH1DO7JVxY3+YSnjsiTIIwubuBndJKbO2t/DbPVShzLSpuF3bf+Go+YRP+mZD+B49GqtRgPtHVbUV7oZtcV3Z/LWdKm3w=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB6533.namprd10.prod.outlook.com (2603:10b6:303:21b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 15:22:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 15:22:19 +0000
Date:   Tue, 4 Jul 2023 11:22:17 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 33/35] maple_tree: Update testing code for
 mas_{next,prev,walk}
Message-ID: <20230704152217.q5ovvsvwgdcshs7e@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
 <20230518145544.1722059-34-Liam.Howlett@oracle.com>
 <CAMuHMdV4T53fOw7VPoBgPR7fP6RYqf=CBhD_y_vOg53zZX_DnA@mail.gmail.com>
 <c5f29a53-aae2-1d1b-9c98-5878a046d1f3@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c5f29a53-aae2-1d1b-9c98-5878a046d1f3@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0009.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::14) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MW4PR10MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f0578ef-b035-4357-3f56-08db7ca27544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rdhlUmlyF0I5U9PIUTPmpQwVbnqKKynkYSyrhCgnWRl1f/2MaB1RpLYPkMRUhznlQkAQXuPu6FO/Q3redkyw+pUG2qioSB/Eepv4eacw6Bf0LW2TA4phYA6cp48HYaVThiHLe6fTYfaH+HzGxNHHVxLw6rmq1HChDPVU+AwgO+Rcz10KpWRFJ6prTdgMlR8fAw0O4rxr/YfIHWQKGS3xKYR1ga6ZfNkdTgXQKDjTuYxrNn2ZneBB+xS8VySMwHj6qP6M/XDUUQbKi/KEMdhZLfqplHix8Lw/gZ3e8vh5iGTIrb78Cip/dk/akb2WP8kkBP1flvJCdhk+k4zodc7NL2Yz7ti80luf9RebwRA3s+QX60/V4jblamV8LTPhNghHmPGQPaMxu2y7MEIcAyxhpTWlcyAW9agC/1V9gXTdWFO6zDKu8K4o4XxIHI1qZ8007DmAX1LfYxgqbvEEk6bprSvJzy4JqUuVea90Tbk2X0nuNH6vHnVYr6Bb++b3Y4w/2ziS/TRiGNfOeFDIve6xGBIrHU0XQRzWJHhB07pLOcHoUVj3QQryIcgg1zQAjekP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199021)(38100700002)(186003)(26005)(1076003)(53546011)(6506007)(83380400001)(15650500001)(41300700001)(5660300002)(8676002)(8936002)(2906002)(6486002)(86362001)(6512007)(9686003)(66946007)(4326008)(6916009)(316002)(66476007)(54906003)(478600001)(66556008)(33716001)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXRMRXhCV1RWSk51WGRKTGJsMnJsWGVPQVJZSnhsOG5keGs5OXpBQ0dLRkZn?=
 =?utf-8?B?TjdORmJRZFZROVVsTXhIdGJIc1Y1c3d2VWxYRFhDTkd6K05BUTR0VFVCWlZ4?=
 =?utf-8?B?QmZ1MW1Ocm80dWYvZ1lWUTY2NytHZnZwYlJVTHFXSUo0THVFTUdxWU5VR013?=
 =?utf-8?B?bUQ2NThmeHhMdkgxYXhhT1lZdWEyNStMUlAyYmxGck9CY0pwcTNtclU1N21V?=
 =?utf-8?B?TURoZHF3M3lkK0dmQ2xTa0xUQjJCZnorVVA0NWxEc1ZqV2NlSEpGWlJmNDhn?=
 =?utf-8?B?MkdwK3RURGtsYjhjOWhSbDkzUEVqMkxHckFTampGQlZSRUJIc3ZQcW9heTRD?=
 =?utf-8?B?YmdTVTg5bUFjdGVyMEZkUUhjUXZraGtMQ0NRVHBVeXhldjJQNFltdzRZT1pV?=
 =?utf-8?B?TnFOelJ2UEJwbVRhUUhIeEtLYXljUjlCL1FRSzF2LzUwUWl4OGsyL3pPcmNS?=
 =?utf-8?B?Tk8zNnI0WlZUcFhqVkwwVGhab3lXODdSWjFLbXgwSmpzYnQzM000RDlsM0Vj?=
 =?utf-8?B?R2daejlWUjZMTTA3MkNEdVI2MjhjazVRRjVrUGh2a2pkVEd5RzhFZ1k1a0o4?=
 =?utf-8?B?SWhZcThHSXkxcnVrNC9qU1dHM0pLWmhDT3BINSt5d015WjlnWmpZMnlrNS9m?=
 =?utf-8?B?VU5BUXY3RWZFSjlQQitxU3BlRXZQL2tnTDVNUDljcFg0YW04UnRSNGYzeUkr?=
 =?utf-8?B?Q2pSY01jZVYvdXhqZzMvdWtjS3JncloxaUFRZjBBNUg1V01DN0xLTnRXUUJ3?=
 =?utf-8?B?V2RiTHYrekp1TDJSd0V0Q0RyNERtQ1JwbHBjazFXS2VBajUvOHFEMFVsMEFM?=
 =?utf-8?B?ZDBQTmgvRUhvNkxnOG90Mk1xcTY2cjdsMFp4YjJ3cVl0S1ZqQ1hnaEh0Kzcz?=
 =?utf-8?B?ZlhiZE5GQllQVGoyZXhwTkowZnZOZnZoc3c4YWo1eENUYkhiYjdCeXdSbHJU?=
 =?utf-8?B?dVZ1S1BCb040UmlqSitUQWdhRlgwNnN4QVJ3WGNxU040N09rc1RZNWZqL0FM?=
 =?utf-8?B?TWRoSzFBRVAxMlpWQnNNQTMyMjEwMDUwc2tpZlhuak5SMkdlWTBobFVwRnZj?=
 =?utf-8?B?amhoZGZncGVpMFhPK20xM1M4V3lraDRxOWg2SC8rYjA0ZkhQc1A5S1FDNTZV?=
 =?utf-8?B?aFE5cjdyV1ZkMnNyTmlMWjhDZHFlZWRkTjR2cXdzUkFycXprcS9zQ3MxQk16?=
 =?utf-8?B?R3RGRHNJYVB1Q2M1Vm51L2MrVlZhZDhSVE55SmpGZ1p2VEc1OG54blAvT01U?=
 =?utf-8?B?K2JNbUVJdVVBVnV5NEE5UHlKTm9EL2I2TnZVNkI0L0NZbFN0bURtcmcvSW5n?=
 =?utf-8?B?SDFndkhMTmZpd2tCVStDTmlSckdQSnRzMHVLZ2xpczJIOUU0S0dlSUdPV3RE?=
 =?utf-8?B?V1V1YW84SXhPR1B0QzZFbHBvcGdhcjliMVc4WU9ZNWp2RHI3SE14K1haOTJz?=
 =?utf-8?B?ZWhaQkpuREVaQzFIK2Q3Y2xESTZHRHJ5aHV3SndTckFRNUNXVlcwOFU3QXk1?=
 =?utf-8?B?WWhxcXdIRURiN0tGZzN2NjM2d05jaGdGN0s4dkxsUFYxLzN6cmZncG9KemVG?=
 =?utf-8?B?L0Y5bGxObmpwd3RVWkFyK0NPbHhDWTFhTFJPVDV6WDUyaXdiZzZoVUI5SjVU?=
 =?utf-8?B?YWcydmh0cS9GVnc0aTlYdmdTek1LVk9XcEM3VWV0aFhyc2Y2WUVtZS9OanQw?=
 =?utf-8?B?eTQ4anFIQitNQmIzUHFHRjRwTmwwUjlPY0QrK3VxTksyT3Ivd2ZEL1VoQk91?=
 =?utf-8?B?cmswYUZzRDJiaElTUVdVTlFzeXVuM3BkcEpVMnUvRlNlT2N0MXNLQk1OQTRt?=
 =?utf-8?B?dEFxWDlEOUF1ZE05NHBYcjczNUFUN0dBekc2WnFOWmsvbjlZczBGL3ZYanFS?=
 =?utf-8?B?WGpSV1doQzBEWEdmYVZWMU5HaDh3T0grSERId01icml5YndtTzdVZG1QVUln?=
 =?utf-8?B?NmhwMjIwM0puQTIraVBINUp0eSsvMndFU0E3OFJiM09GV3RqdzBTQTllKzdH?=
 =?utf-8?B?Yjc5YkNCUlpXWmhJZVJMSWZ0SnVlSktWOHJXdWc5dzFKS1VZNFVUNC9UKzJs?=
 =?utf-8?B?aHp2NnFWWUJDajZZYnUxYjAvT3FVTlF3bWxBdkREajJZYXRVRmxIcEpTN2wx?=
 =?utf-8?B?Rng3U1FKaFZZZjllWDM0RmlFVkh0ZnYzNVYvMTdxTGxodENadXZGUnorbVhU?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MVdKMjBBWUZMNGdaN09aVlR4MEJJVzJsRDl0d3ZuU3FuM2tVVUZZSjJkWHRs?=
 =?utf-8?B?cDdCNVVjbFo2WGNDbW4zTUJqLzZrQXF0Qi9MODBJR24xTGllTW5yeHFlU01W?=
 =?utf-8?B?M0FOLzlNZk45Tm5INTZzbDRQMHVJV0FZWEdTQkd2Rm5QQUg5YlJ4eVdwWW5m?=
 =?utf-8?B?MHplazY1WjZRWHJMbVF3L1BTTVM1ZllLcHV6WjJmS1JuemJvaWpZOWwyUnBS?=
 =?utf-8?B?a0M3cURUS0lVUEE5UElsc21jVDNNNXJVcWxyOVI4dUxEMTJhdTViQVBTZ2ti?=
 =?utf-8?B?M0d0SUVGTjRuZXBZMWdZRnZ3ZVFGbVUrTE5RWEFwSkdDRkx4aXg2WmFwaGR4?=
 =?utf-8?B?c2hQN1FKdW5OR0JrWEhEajNxNERVWFBrbjV4bHFzSXVkUlBJUmJRYVBHVlhz?=
 =?utf-8?B?V0dFcmdLVXM0TGFlMDY4bTZvTVFZUnZDVVN3eGlRUXdrUGFDV0VOTzdtVjdi?=
 =?utf-8?B?ajZCNWhoVWNseXdOMTFDMk8zSjhaMWZhTkxvdFhqL0V0bGd4cDFuSGJJK2Uw?=
 =?utf-8?B?TzZtUWNBVVNHQW1xT2hzajJWUm9VNTRHZDVrMi81TTl4ckxhZ2JYb3VKVnI5?=
 =?utf-8?B?NWkyOXFRYUM4RXRRRDNPZkRWU3FIKzdaQWVmcTc1d2pJSnlVajVjbEdNMjFX?=
 =?utf-8?B?Z1NUdVY4NkR2TzdRY2VvSEcvb0NYeVg5VVY2V3hTTDFIQTZORjBUUURnMnp0?=
 =?utf-8?B?M0VYY1dTUzhUeVN2NmVsWUpBMWZJb2x0Zi84OFRQVzVPdGNMTGlKd2RIbElo?=
 =?utf-8?B?UjZiS21XRmVzaElFVnVRcFZEckQ3aEZCcjNTUVJKelp1L2FTa0ZjV3BXdXNa?=
 =?utf-8?B?QWFYa1VHWlROVHNBUG5IUGJJSisySjlMdGhqczFGVVlZbG1vYzVVb3lNdlN0?=
 =?utf-8?B?eWhDR0pZaHRqUmYwbWpob2k1eFBZWTY0d1dHYjF6dzVaRHZXL1hPMmRoMDQr?=
 =?utf-8?B?WVhFZnhGWTc2SEV4VHkrd2g0LzhjN2lBcTZBaFZoaUxCNXR3OHZJdmQ1TExN?=
 =?utf-8?B?Tkg0ZS9EbkZwK1R6ZmRYK1lTcFl5aWhLVVlDQ05lYlRZOHJkT2ZWcXhwbWpv?=
 =?utf-8?B?R0ZiYVIrTmJqK3ZIa0U0MVBrNVRwUENhcDREZ2V1WjVHWGZhdG9zOHNobjho?=
 =?utf-8?B?N2JQMWd2NXBSaEo4dVY0dm0wUlFGbFhKUDlVNkJhSnR4UWg0Q3UvVmtoSWpI?=
 =?utf-8?B?ZkZ0S3NtdzRoOEVESHlvRGhlYVFyaU93cFd6MTB0bmUwZXBTTUliSW5sU1Z2?=
 =?utf-8?B?Z2M2ak5FNE4vZlNuUFVMYVg2VkxRcnV1RnJWN2NxME40ZFRmZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0578ef-b035-4357-3f56-08db7ca27544
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 15:22:19.8260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjjvjjMdg/oSMqfQ1RjWFWcqxTHwTzoegc/kOtGtwDk1VjsvrqXEKtoIJJCq6DttaHIcQ54qGcArooVch84jpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6533
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_10,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307040132
X-Proofpoint-GUID: WitrS6zs0WO0qa0H_DcPF1Z8VHLOGaQU
X-Proofpoint-ORIG-GUID: WitrS6zs0WO0qa0H_DcPF1Z8VHLOGaQU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230704 11:11]:
>=20
>=20
> =E5=9C=A8 2023/7/3 02:20, Geert Uytterhoeven =E5=86=99=E9=81=93:
> > Hi Liam,
> >=20
> > On Thu, May 18, 2023 at 9:37=E2=80=AFPM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> > > Now that the functions have changed the limits, update the testing of
> > > the maple tree to test these new settings.
> > >=20
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> >=20
> > Thanks for your patch, which is now commit eb2e817f38cafbf7
> > ("maple_tree: update testing code for mas_{next,prev,walk}") in
> >=20
> > > --- a/lib/test_maple_tree.c
> > > +++ b/lib/test_maple_tree.c
> > > @@ -2011,7 +2011,7 @@ static noinline void __init next_prev_test(stru=
ct maple_tree *mt)
> > >=20
> > >          val =3D mas_next(&mas, ULONG_MAX);
> > >          MT_BUG_ON(mt, val !=3D NULL);
> > > -       MT_BUG_ON(mt, mas.index !=3D ULONG_MAX);
> > > +       MT_BUG_ON(mt, mas.index !=3D 0x7d6);
> >=20
> > On m68k (ARAnyM):
> >=20
> >      TEST STARTING
> >=20
> >      BUG at next_prev_test:2014 (1)
> >      Pass: 3749128 Run:3749129
> >=20
> > And after that it seems to hang[*].
> >=20
> > After adding a debug print (thus shifting all line numbers by +1):
> >=20
> >      next_prev_test:mas.index =3D 0x138e
> >      BUG at next_prev_test:2015 (1)
> >=20
> > 0x138e =3D 5006, while the expected value is 0x7d6 =3D 2006.
> I took a look. The return value 5006 is correct while the
> expected value is wrong. This is a problem with the test,
> it is not compatible with 32-bit systems.

Thanks.  There are a number of tests which deal with larger numbers that
do not work for the 32 bit systems.  Those tests are put within an ifdef
to avoid running.  I guess this one will either need to be altered to be
32 bit safe or added to that list.

> >=20
> > I guess converting this test to the KUnit framework would make it a
> > bit easier to investigate failures...
> >=20
> > [*] Left the debug one running, and I got a few more:
> >=20
> >      BUG at check_empty_area_window:2656 (1)
> >      Pass: 3754275 Run:3754277
> >      BUG at check_empty_area_window:2657 (1)
> >      Pass: 3754275 Run:3754278
> >      BUG at check_empty_area_window:2658 (1)
> >      Pass: 3754275 Run:3754279
> >      BUG at check_empty_area_window:2662 (1)
> >      Pass: 3754275 Run:3754280
> >      BUG at check_empty_area_window:2663 (1)
> >      Pass: 3754275 Run:3754281
> >      maple_tree: 3804518 of 3804524 tests passed
> >=20
> > So the full test took more than 20 minutes...

There are a large number of test which are probably going to take a long
time to run.  I'm not sure what should be limited to avoid testing
taking a long time on old systems or even what would be acceptable?

> >=20
> > >          MT_BUG_ON(mt, mas.last !=3D ULONG_MAX);
> > >=20
> > >          val =3D mas_prev(&mas, 0);
> >=20
> > Gr{oetje,eeting}s,
> >=20
> >                          Geert
> >=20
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org
> >=20
> > In personal conversations with technical people, I call myself a hacker=
. But
> > when I'm talking to journalists I just say "programmer" or something li=
ke that.
> >                                  -- Linus Torvalds
