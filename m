Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A0274D980
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 17:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjGJPEY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 11:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbjGJPEW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 11:04:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9476124;
        Mon, 10 Jul 2023 08:04:19 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ABCcDb028014;
        Mon, 10 Jul 2023 15:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=SCUTGvBmzdPeNNwByUEISWHskVk4tNH8rLk5FcA7duc=;
 b=J34okC9ynK/9eGEx/V8Ju6s+0UkkI0qvT1wK5CBfGvwOSrlvCYAXkLJr8jfVkAwg+eo1
 4iqq0BhqFkpFiycz4rU9hB260GqYKWirxbysPIoKo/M1ZvAY7UkNklAGxDwwJGmkd42K
 YB4OyXUh+cFvmFLtVPKyQMTFB2oOZRErJAcxLxPXXxI9+wR1K7cyKa0cbTRTWhf137BJ
 040g2X4fSfFSRRyH3fSPloW7ugCYtp4rs4aZz68BzfHSy5ulardp2iVdGwZGIO3SQJl0
 ujAN5sVk/GMjOyKjs/s2P9cj7tguAe0NedvgLdsC0jpqUKWJjITGpZJjPjFClM3HIfIc Cg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrfj60mr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 15:03:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36AEYmbn021331;
        Mon, 10 Jul 2023 15:03:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx89ukd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 15:03:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuIuLQWQOX/hXWof7bPznLli1rs7sAjk6k0u23z4ahrIC77SksO2hn+XyIJPRpJs+qZRTIt5KUGUZKlcX3z/EWnY+hdObVZd87fj88BnQR0pgRUbhny3aJuHmiec9LCLabn9j2UEHygALoDYZYUnhwDO8Th9baEj/SSCb7JcU2xgaz4JZRnA0w0o5lszdOdnp51ewxd0dvAT2LIoIi5ZslDD/eW2lDyE4adAj3Fi75tkzVxVczoZT6mpKCd1nMBgN3QC/ZiLKtP7P21WsWeEi0O9Iw0mQgA04j7u1k1ntnlEBQ76JWNFwjLnOZcefCu/zkQUo6ZvUZOY7WN2sr0b8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCUTGvBmzdPeNNwByUEISWHskVk4tNH8rLk5FcA7duc=;
 b=mep0wmwk8Ty9P6V7Hdfgt2HWCBykyF7H2Wm/B+T0+InjVxehHAxF6DaU6CCIPHTtXPId/XwEknWd6xxrKKQRATXyKtT3tSjPAgmI9Gyeg9W52tgbQdTA1U2HkHTGzZ4PtnoL5szrSHuLueYzIBc7uvkdzQXeZNCtFecL0ah2yW7+wyKwYC02oSUmgjiCRkngwNV4vk3COKB9jkfI0Ta2MvpgEG64ifeZLEB09NlklB8scQShcxn/S/QFdQYgzSkYjYckKR/hkegeSuJhfKXfBEEOU7f1ruiAOLfRlCiH9vekIG+1NtXGQZqNamFYbt7N9NRIqvM+fWc1VJTMG0QiKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCUTGvBmzdPeNNwByUEISWHskVk4tNH8rLk5FcA7duc=;
 b=yZFG4BSs9y+CIFzHhMHaYbSF2q9uhzSgiz6yRtEzgJnGWV7PTKLqAbvVVCOHRfQN592WA/47E8FiZSolnDI4h5b+sYQ341S47EbazNTL1kCK2h5P+VQWVonE4szmyFn1Sdsfx0OhZczVu9taIkBbaRhfffbUxzD5pFO9TBeNGNc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB4127.namprd10.prod.outlook.com (2603:10b6:208:1d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 15:03:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6565.026; Mon, 10 Jul 2023
 15:03:46 +0000
Date:   Mon, 10 Jul 2023 11:03:43 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 33/35] maple_tree: Update testing code for
 mas_{next,prev,walk}
Message-ID: <20230710150343.el2dioaubrd2bmbr@revolver>
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
 <20230704152217.q5ovvsvwgdcshs7e@revolver>
 <20230707192853.3hnl5zsozzisjh26@revolver>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230707192853.3hnl5zsozzisjh26@revolver>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MN2PR10MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f3663d-52b1-4231-5ad7-08db8156dbf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dBGxmem/jgt40icmLzIRKRMRMywhpsFGKvFT9m97xtZFwz9MBrrB51q8MnYEH0+Gqk3jCxFaCeEYjxgnQgACQMifWEHtw7jisy6YbQQ/R0IA/KCGhLY6WAZPyOO4eRwKNmSRJi06JI678IKMNsmjh9vArOwzvwA2+Eh9OT0iEhhERsv9tuqi9HWI12c3ikBlr/FnOFjuMaTL06pKb/lp1iVixqQP8Q7BRSM1aGMxw7mdwna30DSeQYy6uz/cUenzEOK5CCiaMsB7S1jxgJ85fGv25lXumoYfy9IuKpNINyUBRUQhIcOyMfu7EueWe2p/YChbSosdP2CQlytP3ebmjsuJtHbBtEBrxdg8iG31hYtyuL5rD1G3QTz9TCar77JXetWP+QfLqeULEGbffbCwjKWD+DOgnEMn4IELRQyu8xD9qAwwpK94UjSmSnGoDsEXvoIexe4dtR7z7KWTmG0zrYZIAVbY/mgFotzaU8bteE4l0IHWM1b7NRrCRqvbiPVNmgau4MdoSsi/zwpBbTNvcSE0Gvo6ExRDtBF9mXe0SNELi3hhAsfuWqU7JtEUKOGS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199021)(86362001)(38100700002)(66899021)(6666004)(6486002)(110136005)(33716001)(6506007)(53546011)(26005)(186003)(1076003)(6512007)(9686003)(5660300002)(2906002)(66556008)(316002)(478600001)(66946007)(8936002)(15650500001)(66476007)(8676002)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzF6bVZkelVTQksxZmFCUHpVVlJHMWxDSnBWbU80dHZsQlpEOGxEenVqY2c3?=
 =?utf-8?B?WGxKMTE1TnpmdCthcWthd3gzSllSenI5d01kTFVPQkgzK3FFQ2VFRTRmUjRO?=
 =?utf-8?B?ZDIzU0NQUVhNdlM2WW9SMklLYVJiUk1WMUd6MVNYbTU3QW1ldC9Wd0FMRlZk?=
 =?utf-8?B?ek4veXk3ck5mUW9DeEgxMlNMOFVzcEpUR1pWbEdkQmZ1ZzU5dGZRbFJycm55?=
 =?utf-8?B?RFNUcGEzWDR3MThkTkJSMFBpeHBsWDIwMUkrMTJhS0JyNjA5SkRGdEJKb3k5?=
 =?utf-8?B?THl6UWMzVGRmUGVxSnpZanBFRHpmRWlaTkh0dDBLbThrVmIzV290bUpFb1lU?=
 =?utf-8?B?Y0hnbWpNelFvWEZ4cEVhQmZNSkJmMEV4TmZPWnVnNm1TUE5vQzJBU0Vnck9N?=
 =?utf-8?B?MlBDZHgzQlQwTHk0bjgrNGFVVXhTWjhRWkdXN0JVSWEwTHVuL0dHbmp0eFFv?=
 =?utf-8?B?SXA4NWVOVHlvZlA1MUw5NHJCNHI5K0RXeEZBVG5POWQySFIrb1UvZGNvV04r?=
 =?utf-8?B?UXVuU1pKbjJKeS9ST3VROVFhNEpOOUQwbnVxTk1aTlBGN3R6QVNENVV2TnN1?=
 =?utf-8?B?Z2lMZjlFaGNMeWZQbC9EN3N3dXBHZlR6RHpMMjEvWG9hTm5adXhkRXAxRFJR?=
 =?utf-8?B?cFZhLys5bTFwcXo4SEVRQUhvRmFxR2RESWtocmRVRk00enh5akdwMmkwSEZR?=
 =?utf-8?B?UGdvZEtTZ2FwZWh5bW85L3VNL0tpN0ZjZVh0ODZ6UFNqTFhqVkZFWWVDQ1FQ?=
 =?utf-8?B?ZmQxNzRyQ1M4dUVwM05WNWt4bU9xSUsweUdmOFR4RnhPY1A5bEpPR1M3YUFB?=
 =?utf-8?B?VWp3bE1sQmNBcER6SFpPZDhMNUViQVdDU2RacmVwT1lRL1NCemswKytEYXdh?=
 =?utf-8?B?MzgweWUwNUorc2QzcklHU0IzQitUYzNTa05LeklkMzlNTzQ5WDFpc2hZeG1s?=
 =?utf-8?B?aG9SVGwrS3hSN3ZCMGNkRTFpbkR3UzVQMVBvcWZQVFowNTNGbFFOdGNFdDly?=
 =?utf-8?B?aXQyWFhuTnZFR0R4WnRONFlFYUlCZlM0bDU4dFUyaDluVFdYRFZkV1h5Yk9C?=
 =?utf-8?B?QU10ZVFtblA4SWJkb0RuR3VxdENpOWkxSkRFUmFxK0g0dUVYL2xlQU1jSysw?=
 =?utf-8?B?MkVobVFIZ2VuMXMvWEpBbHhMZGtlWGtFdDFTbFJLcjZiN1ZLd3ZqMVJuMVdq?=
 =?utf-8?B?QzE2a01JYlNoZjFNR2ZkYVdCQkgzWEpKSEpySnFXam5hbmZZSVpXbFR5VXhz?=
 =?utf-8?B?Y3hKMFBNM1lQbVRtdUMvYmI1bWJJRk4xMzBZZjFiclFZcnJ2NlBUQWJiV2lw?=
 =?utf-8?B?TXRvbzVSR0Rsb0Z0VkVpaThRalZVQVkvRW1ETXJOcjNUbnY2NENLbm5BMjdw?=
 =?utf-8?B?ejZnRitoSGVxOWF3RkRjTjV5R1dMbm5SUitVa01LU3RLcGVxN3h0V1JYMFgv?=
 =?utf-8?B?WUxkZDlaYkhRVmZMV083dVBPVStsVFdWbVVLZ1I1bFJKRWIvYk1wcmduWlVI?=
 =?utf-8?B?OWdKVk9qa2JudWJuUkNYRytQR3JvUW8xb1B1UWl5cDErSi9lVmVGVjlYVGhR?=
 =?utf-8?B?VzlkL0E0TE5GcWtzVVduYUlEdUFKR0ROOTVCSk8zODJ2dlNzTEMrUUNGajNj?=
 =?utf-8?B?dXJZOWpvWkh4SWJMSVd5ajZoSW5KNThOeXFWazdLbGtDODRhQk1lV1lpalYv?=
 =?utf-8?B?dlRuUkdJcWNPaHRMbi9VWURkTXFrbGNNQ0lzTWhWV1cyVDBBM08rUm16dnNC?=
 =?utf-8?B?MEdSUG8xRVQzVmZQbXd6Y0QwWjdvbUlZUW9sNFNRRVY3b1FXQ1crbUJCODFq?=
 =?utf-8?B?ditzN2JPNnZWTzh2OUJuc2Z5UG0xTnVaTmlFUmxqREdKNGtkcGtpUVdTWkIy?=
 =?utf-8?B?Qi9BN2hybVdzZHpPVE1QSGt4cWYzWXRJNU9jMXZOcjRSTTFyeEhFT3FCOXZV?=
 =?utf-8?B?azdTS1BMUEU2UjBzVE5hdm14TUhHcmd5TjM0RkNXSXlNVVl2N2JPdFdlVU81?=
 =?utf-8?B?S05oa2R2alNNMEZPUEM3S2JWQXJSTVo5MjZLeUtxZGgwL1J5MTBhd3JWdEpZ?=
 =?utf-8?B?blB3UGdXZCtkOWttK1N0bU9pSWNTbXZwcituMW1jc0wzVGdGQ2NBM25CVW9D?=
 =?utf-8?B?UmZneXRpNW8vbUM3VnJoS1JlNUZDejl5VWRoYkdmdmhZY2ZIRVZDRC9JOUpL?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RFJVb1NzZm14WHpTS2o5NmpYeXY3Y3EzWnZlOGVLZklJRGJRT0k1dzBMUDFY?=
 =?utf-8?B?ZHhSY08yZzFnbjBhb0o1NUJSVzRzcG1BM2kvVnVvMU9JdlpQQjVjVHpWa3BF?=
 =?utf-8?B?TWdjNkx1R3FiNS9FQlk3V0FxYW9SWGc3S2o3NGY1ZWhBYS9WQlRia2duZmcw?=
 =?utf-8?B?eUQ2Z0xmU2lnVEs2TDBvZEtsY2ltMTJxUTBXTVYzR3hPTncrY2ZwbXNidkhJ?=
 =?utf-8?B?blFpNDVKVWp5U2NnWEVQaEhSVmhyRmxNSVdPdFlvcTdubTJMbkxEeExCTy9l?=
 =?utf-8?B?R1lxVWM3Tk0reFk4bTNoRzBpUHM5cm1CYnJVSFVlaFhYdU1oWS9BNEgxZHlO?=
 =?utf-8?B?Vk41bmRlWkJPV21yc2s4MWRWNW02eWkxUEFpY2VJc3ByVE9hY242bmxzS1ZR?=
 =?utf-8?B?dXpMOHBDTy9qWVRub1FVREo0cEVwblhjbFJZNDdxZ2RIOG9KUDJTYWpKRm4z?=
 =?utf-8?B?VDZSMTRNS0pMQXZGdXJ4eVhyWE9xZjhIWlFMQ0tTOXY0b0puVy9GQnp2NXVU?=
 =?utf-8?B?L1lsdkFIdlJvSDlsUTlkR3lkVll1OS8xOTdEZXVEbXlldk5Pa0taYS9Zc2l0?=
 =?utf-8?B?eUM0SUlReEp5MEVJWnFkUVQyeUJUalpiMVBNNDFPbWRPUE51R1pHU0NLa2xV?=
 =?utf-8?B?bkNIWjgrU2p1d0pWc3B0cHVWRkVrU3prTnhUTXh5MDlrZnV4b0tIWVAvUTFT?=
 =?utf-8?B?c0gvTlBNaEpBUE9YbHpHSEtpUmhFckZFeENoR3hNSjljQTZMQ0lmSlJ0c2NR?=
 =?utf-8?B?WWFqUktmVndrWThETE5CYzBScm1WTVQ5TzVkZkZldGJsM0VxZ0FCbVAwMDhR?=
 =?utf-8?B?c2kzZTZSTFVFZlRDamtCZWdNM3JzazJHZGphVEJBM2RWbkgvcEFhQnZvTDFK?=
 =?utf-8?B?TWVyOUQyeXRlWTdTR3JxWENSRjR5bW1rR2ZOSW1TTmhrRVFlV1ZzbXNDZ256?=
 =?utf-8?B?K25md1BvS2NVY2ZGNXFkNFIwem4zSEpxbDRxZmVsSTlKbFBHOWQrR1hkZEdS?=
 =?utf-8?B?a2JoRk00c0FyQ1RWNU1DK0tFZ0o2bllLUFFlK3AwV09lRXI1T0pVclNLNFBK?=
 =?utf-8?B?NjlXVGlnWkNVQ1ZKSXFUV1l3c1hwSWc2VnZ1K0ZEUzZick9OVDV1UzRQa2RU?=
 =?utf-8?B?OFpiVFd2U3BYaGpRVFduRkVsbll4cHcvenpOd1BsWDlwcU9WelEzWnBaWW00?=
 =?utf-8?B?UThaUjFIVVg4bTB4SnoycGNtSUZXL2ZxdGgzZDVvUDBFOTRsMDAzK3doVGxX?=
 =?utf-8?B?MjMwUXdiK05aaHgzUklWUGhQYzVHVWZDZk5qUnRVZFM5N3RKTUs0dkFaZFgw?=
 =?utf-8?Q?23Faogt+t2REM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f3663d-52b1-4231-5ad7-08db8156dbf1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 15:03:46.1845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8kf7e4i74EHki95rHtbClxFtPsyuCS7lZHvdpKN7ybx6cdJEMSPt42WLEPuWCktmSu+TtEULRKhCf4eD82u1bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4127
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_11,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307100136
X-Proofpoint-GUID: 8O9gvPpZ4D1oS9_hyLRPWQPJ0FNvv8o2
X-Proofpoint-ORIG-GUID: 8O9gvPpZ4D1oS9_hyLRPWQPJ0FNvv8o2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

* Liam R. Howlett <Liam.Howlett@Oracle.com> [230707 15:28]:
> * Liam R. Howlett <Liam.Howlett@Oracle.com> [230704 11:22]:
> > * Peng Zhang <zhangpeng.00@bytedance.com> [230704 11:11]:
> > >=20
> > >=20
> > > =E5=9C=A8 2023/7/3 02:20, Geert Uytterhoeven =E5=86=99=E9=81=93:
> > > > Hi Liam,
> > > >=20
> > > > On Thu, May 18, 2023 at 9:37=E2=80=AFPM Liam R. Howlett <Liam.Howle=
tt@oracle.com> wrote:
> > > > > Now that the functions have changed the limits, update the testin=
g of
> > > > > the maple tree to test these new settings.
> > > > >=20
> > > > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > >=20
> > > > Thanks for your patch, which is now commit eb2e817f38cafbf7
> > > > ("maple_tree: update testing code for mas_{next,prev,walk}") in
> > > >=20
> > > > > --- a/lib/test_maple_tree.c
> > > > > +++ b/lib/test_maple_tree.c
> > > > > @@ -2011,7 +2011,7 @@ static noinline void __init next_prev_test(=
struct maple_tree *mt)
> > > > >=20
> > > > >          val =3D mas_next(&mas, ULONG_MAX);
> > > > >          MT_BUG_ON(mt, val !=3D NULL);
> > > > > -       MT_BUG_ON(mt, mas.index !=3D ULONG_MAX);
> > > > > +       MT_BUG_ON(mt, mas.index !=3D 0x7d6);
> > > >=20
> > > > On m68k (ARAnyM):
> > > >=20
> > > >      TEST STARTING
> > > >=20
> > > >      BUG at next_prev_test:2014 (1)
> > > >      Pass: 3749128 Run:3749129
> > > >=20
> > > > And after that it seems to hang[*].
> > > >=20
> > > > After adding a debug print (thus shifting all line numbers by +1):
> > > >=20
> > > >      next_prev_test:mas.index =3D 0x138e
> > > >      BUG at next_prev_test:2015 (1)
> > > >=20
> > > > 0x138e =3D 5006, while the expected value is 0x7d6 =3D 2006.
> > > I took a look. The return value 5006 is correct while the
> > > expected value is wrong. This is a problem with the test,
> > > it is not compatible with 32-bit systems.
> >=20
> > Thanks.  There are a number of tests which deal with larger numbers tha=
t
> > do not work for the 32 bit systems.  Those tests are put within an ifde=
f
> > to avoid running.  I guess this one will either need to be altered to b=
e
> > 32 bit safe or added to that list.
>=20
> This test should work on 32 bit systems.  The problem is that the test
> sets up different size trees for 32 and 64 bit systems so that there are
> at least two levels in the tree.  The test that fails checks what
> happens when we shift off the end of a tree - which differs depending on
> the number of entries needed to create a two level tree.
>=20
> I have a fix for this test, but I will hold off until I test in a VM to
> see the issue below.
>=20
> >=20
> > > >=20
> > > > I guess converting this test to the KUnit framework would make it a
> > > > bit easier to investigate failures...
>=20
> I disagree, I can see the above failure in userspace on 64 bit systems
> by running the following in tools/testing/radix-tree:
>=20
> BUILD=3D32 CC=3Dgcc make maple && LSAN_OPTIONS=3D"report_objects=3D1" ./m=
aple
>=20
> In fact, that tests more than the module as it will run RCU testing as
> well as using direct tree accesses for another set of tests, which
> revealed another test is also failing for 32 bit around allocating
> nodes.  I also have a fix for this now, but again, I'll hold off sending
> them out until I see the below failures.
>=20
> > > >=20
> > > > [*] Left the debug one running, and I got a few more:
> > > >=20
> > > >      BUG at check_empty_area_window:2656 (1)
> > > >      Pass: 3754275 Run:3754277
> > > >      BUG at check_empty_area_window:2657 (1)
> > > >      Pass: 3754275 Run:3754278
> > > >      BUG at check_empty_area_window:2658 (1)
> > > >      Pass: 3754275 Run:3754279
> > > >      BUG at check_empty_area_window:2662 (1)
> > > >      Pass: 3754275 Run:3754280
> > > >      BUG at check_empty_area_window:2663 (1)
> > > >      Pass: 3754275 Run:3754281
> > > >      maple_tree: 3804518 of 3804524 tests passed
> > > >=20
> > > > So the full test took more than 20 minutes...
> >=20
> > There are a large number of test which are probably going to take a lon=
g
> > time to run.  I'm not sure what should be limited to avoid testing
> > taking a long time on old systems or even what would be acceptable?
> >=20
>=20
> I'll look for these failures, perhaps on i386 so I can have them run at
> a reasonable speed.

The check_empty_area_window issue did not show up on i386.  I was able
to reproduce it with qemu m68k nommu build.  It seems that there is a
bug in mas_rev_awalk() where mas_logical_pivot() should be used instead
of mas_safe_pivot().

It's a simple one line fix, but Peng already has a change in-flight that
will fix it by always setting the pivot and render mas_logical_pivot()
useless.

I'm going to reply to Peng's patch to amend the change log and add a Cc
stable.

The remainder of the failures you reported here will be fixed through
akpm's branch as fixes to the maple tree testing.

Thanks again, Geert for catching these issues.

Thanks,
Liam

