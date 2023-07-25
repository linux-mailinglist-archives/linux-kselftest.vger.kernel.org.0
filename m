Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A20A761F80
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 18:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjGYQun (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 12:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjGYQuk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 12:50:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B4B212B;
        Tue, 25 Jul 2023 09:49:53 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PFrxGW004874;
        Tue, 25 Jul 2023 16:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=02OsDrf+4qlUdnLfxeEA3faJQedR4/3Lw1Y3WhMQ330=;
 b=2w2dbs9B1gE7XvNusCuT029DWElIvDj/QRtt/HaHu8fw0RozVOavou3DuwhAQadsEHh2
 t6Z36oLcY+3a/NY9U9xhKhwH9NJg/1Gg7ZvXzIW41EZji1e2uw3suWs5UD1z/Hxc0IX4
 tE5rqbN3Cm1Kbc+EqwexDRWTiJVFJNPWGJljsNmkMy1z70Rg3aw2UxroThwl95Y/ZA1o
 MvU0PW90FMG29wixOPqrdwSXul8IDfStILJbN+ROPXRZwj5elyjGTMgvqAQaI7obwHd3
 /g9/PIQukRGdDUhei0QNLjBhZtrrm7XMgk3ofoayO0C80ZFXovdfMuNJKc9/gtnlrGQ5 PQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s06qtwhjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 16:48:16 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36PGG2S8011965;
        Tue, 25 Jul 2023 16:48:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j59rqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 16:48:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g167S4WQoDzbBbocLqqaWOI4+zPjutYr4NytmfJnG8emOmXzYudhGq5VrDn2YSVeDW6Alcs4rpl3OLsLX8yaeeZJHoFVZVsjaZEHWvhz44RY8jQboiiGh++3f/7LcK4VYoitPWa9Ev16CkaSr7C4LJz0V55ZNkIIRaDkU130okMIhQLfjbL5olJGY+I6WDrXA5UhyUqdjAQFj/+M6DOIvhfEfLzvb806clZ/JhGZ3DNMf52GYleFqJx7iYHI38yz4yUF9U0TNvE9tfCeKLcHrwdsqj0DHd1rKVyv+HTu7kNOLCVPLMdJuYT9t0PA0Z8/sGR0NM73+Xt8pMUJ2MQ03A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02OsDrf+4qlUdnLfxeEA3faJQedR4/3Lw1Y3WhMQ330=;
 b=T4n22/iVr7bNXjWtu5JpvhuwMAuppDnRPbfrPp5cS1S+B5SPnJlhTArOQNqOHRHHIqpoxBpKi3ZrTsnGdiFzNTLE0Vwd2wrXnVPYjLsE1otGMZ9cb4MiqIiszvVDfraccOWz2kExC5wu7helihb53xmdUTRe5rNX2RtbiY9pZzdDjS7dKXxe395ASh4uCwfyRYxnxCT2z5BmrBnLeRnsziNJyD9pZIi3hc+HUu71ZedI3Z9L7jh0Ebhj+m3h6eiuiVMiPbu+M+N2HukV66S3Ts2345aHmhNcEaWqCixWuXxdSTko926AyzuVAR8DnPUD4KZRS4QjPRAgwVnh0aoQ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02OsDrf+4qlUdnLfxeEA3faJQedR4/3Lw1Y3WhMQ330=;
 b=JGTwTZTLnXeXJfDI0Bnc6w1wHuW5HQx1Br5vQ8vIYHFz1fiDltGS0dm5NeUo4KK0dgt6SN8ULJC+xYq1S1AbWz/iL+AiB5IWTnIUC2RpViFrTNvb+uoT79JkNKBZQrcv9bAfSyZgjq4jiDfjgY6qQIzPf8HgaPyiQ2bBFew6VKo=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by PH0PR10MB5643.namprd10.prod.outlook.com (2603:10b6:510:fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 16:48:14 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::69d6:8729:ee7c:cc45]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::69d6:8729:ee7c:cc45%2]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 16:48:14 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
CC:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        Netdev <netdev@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: selftests: connector: proc_filter.c:48:20: error: invalid
 application of 'sizeof' to an incomplete type 'struct proc_input'
Thread-Topic: selftests: connector: proc_filter.c:48:20: error: invalid
 application of 'sizeof' to an incomplete type 'struct proc_input'
Thread-Index: AQHZvvi/xI4ekXqIdU+9CLD2lWipK6/KsaiA
Date:   Tue, 25 Jul 2023 16:48:14 +0000
Message-ID: <E8C72537-4280-401A-B25D-9734D2756A6A@oracle.com>
References: <CA+G9fYt=6ysz636XcQ=-KJp7vJcMZ=NjbQBrn77v7vnTcfP2cA@mail.gmail.com>
In-Reply-To: <CA+G9fYt=6ysz636XcQ=-KJp7vJcMZ=NjbQBrn77v7vnTcfP2cA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|PH0PR10MB5643:EE_
x-ms-office365-filtering-correlation-id: 3b83bcd6-2b96-4500-e12d-08db8d2ef035
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ToelUb25iA4GHfhxX8DDYnIOeKw8JexWTBBMoFuJxx2mWbGiqdxyu4vXXUiMuLwqDi0vS2AffqWxnUKNUvLQUBjNUozZZ86zYqNVPZy/YH/Ldh43Nxv/XXhxAk4K0wLf3iy8oFNNZxS7z6YH6wlBm2ZQJ1cWjjYtvAGKVRThqyE01gg8lDKMkmp9PWqY1NHYNCoZG33Ai9Bm9Ft4WH1GfBwzKBnuj4bTzYpYH+pARRkDS/iQAjfdLpnc85XWks3FOkWn4v6/GXEUcJb3H0O65ykARdaAmuSB9fXrqvYdvWXqRtHlTGy/RIh3bza90R+6MyGoKy5suLt5C04syFgOhAIwozfLR5yc/ZBpmBGtFch4B8AKMGs9hGKECQmcSrEgKgz2EJo/idXWBjktfmUranM9BbTLdJWy68LE3JFn8mUvKDP6DU3YC5SMUr7P8lX5otN6SlB0jnhvJkCFATMdpgE0/L420hBYO17xFHZpdTLWFnma2D9tl63vqJfNt+vWvU7GThUWAXZpGqpRW1Sp2ZKnH2SBCl3fv+UGm6+0p2Dvi0Lw91tLHjlQLK8de+Z28XeD4nFKsYQZL9OHFuiKIxRY1lvKDbWUirWw9AC294l/abSC44O9sfEa5adZRAN5kzqZL0Wpjk2wikA3t5eLUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(186003)(53546011)(107886003)(71200400001)(6506007)(2616005)(64756008)(66476007)(83380400001)(6916009)(76116006)(66556008)(66446008)(66946007)(316002)(4326008)(5660300002)(41300700001)(8676002)(8936002)(6486002)(6512007)(966005)(2906002)(54906003)(478600001)(38100700002)(122000001)(33656002)(86362001)(36756003)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkhGRHA3V1hJdXBoR1dqWDdQV2JpeHdVWW5MOUluM3U1SFRKSUZacm8rUCty?=
 =?utf-8?B?dHNxNHZycUVEWmExdkF3Nktock9HdTlEY1ZMTm5EMWNBQmFDR1c1ZWJGZ1ZW?=
 =?utf-8?B?SGNTcG1Id25lN0lGdzRjZXI4VjZBSGNSd2ZPVHNyYW96S1hBRkJxL3FuZHBv?=
 =?utf-8?B?N1h6TEVHRXpZbGVnL3F1bjV4djRwb3pQbkNCS1JsdHI4TkIrT1V3dTgyOENP?=
 =?utf-8?B?RnJxSjhVT1NkZnJkTVhycTJKV1dUVEdxZ21IVkhoeStCY3FpUHdqMnEyRDRn?=
 =?utf-8?B?Z0xvNzF5QUkxQlA5a0FTMTlYK3JndlA2V3FmaWNPaHRHMXFGYzkxTWNrT1hK?=
 =?utf-8?B?ZzYzc21zQndHZ1h3OVBNN3NreEhNQjc0S2dyZ1QwRkJ1K1BOWlBTSzF3TE1J?=
 =?utf-8?B?SnUrckZnSGk1L2NXMzNVRExwWU9ZMXQwemJMY2lNMXFQOHlabGM3b0JleXdi?=
 =?utf-8?B?YS9MNGJqME56WEticnhWQm51KzYyZ0w2alVkT1NVSXBBYytwckhId21oZE5H?=
 =?utf-8?B?SUdRMGZKN1BSb0JMNCtJdGFvcU9CYy9ET044d05Nb3loWGtVYXpoMzROQjY3?=
 =?utf-8?B?azhoQjNiOTh5VUQwM2NFQkI2dHJWRmRxckNhNHVxUnVrYXR4cDFYb2ZtVTFZ?=
 =?utf-8?B?elFKSVpoZmRFelBYbU5lSzQ1UC9JWm1NQlBCNGpXTVZyMmprdHBEL3g2bWx4?=
 =?utf-8?B?V0I1amZ0T0Q1TFlYWnNzZ1ZnTTdsbHMwbDFwVWpkK1MzTUlTbjZKOXl4T1Zs?=
 =?utf-8?B?NHZIdmFnL3FKMEZ0STlFVU1wTGRmU2dac2F2ekVvT1FwNnJkSE14YktkN2dF?=
 =?utf-8?B?MTB2TEdjMzdRYnh0RFI2R3NBVDNnaGdtcmNmSEhVRjRuVFFtTS9qS0NvYW5K?=
 =?utf-8?B?UVorM241VTBRQU91TkNOK1pGTnJvT0xSU1BuQ1dicUJ1a0dVU1JlbU5LUU1K?=
 =?utf-8?B?eHl4L3lyKzVaOVRSMnN3UHZ5OWVEY1p5SnpjQlpGc3REWGJCTlpQMThIS01k?=
 =?utf-8?B?cnRrYjlGYzNOMXNGaUZ0YXl1SStIaTVrMjd2aHBEeXk2dHQ4MzNYdHJoVkxs?=
 =?utf-8?B?d2JmU1d2Mk11VkRscVNVKzVGSVhtVGdiT1BObTMxYjBmeUpuMHFJNFVnQVI2?=
 =?utf-8?B?ZWMyYXhia0MvM2YxWWRMUWxnOUw2U0d3UGNCWVgydi9FdWR4Nm1XMFVYdVJ0?=
 =?utf-8?B?YXFFeGhTdzNNVW1wbkY4cVZJcXNlYnZKQnpEY2xNbnM3eHl3VGNPdGFicTND?=
 =?utf-8?B?NVFoOUtpeWdUaGdsN3NjalpCL05QNGx1M2QxZnNJL3E5RHFua0lya3QyQjYz?=
 =?utf-8?B?cSs0bksvKzFtanQzZmYzaDlRekwxbjJRRmVKTEs0ZVY5VVVsaTE4TkErbG9m?=
 =?utf-8?B?d1FKbm5uc0UrdXZVVGxPb2FGRDVENk9PdEYzQ1hwcGdpaTJQV0RIUE5BYThr?=
 =?utf-8?B?bVZ2ODZrVlFhaFdXNnhmT0JiT2k2azR2OGx2MzdiTktKK2RvOXRjdUFlS2lJ?=
 =?utf-8?B?NDJOb0NZbWtxL25vMUU3aFc2UUdKdUFvbm5BWTFKM1ZWOXB4RUN0bjNmM2ti?=
 =?utf-8?B?aVNXR1lvcUJvbnVKTkIwUkRHQVE5TUhieVUrNm1ibzZGOFl6a0JlYkxoRm56?=
 =?utf-8?B?cjVEOFlOK2N0Mm9FNGt5bFBXYzgxeUpQbTVaUkVIdXU1UmdHWW1TL1Q2a0dV?=
 =?utf-8?B?TXJqM1ZYaWtWYnRFNzFOdVQ1WGV2ZDBQczl2SzdROHp5aTFqdjMvRlp0aGs4?=
 =?utf-8?B?RTl5VTNjeTdhTXVBaEZxZUE0WktrOUNsNW5xUXpwVlRWZmVIbjFNaHZtUHls?=
 =?utf-8?B?bkVkM2pRTFp0VUJMTGpvQmd3d1ExU3JGWXRGOTQyV3R4VTQxWnErSklmWWFr?=
 =?utf-8?B?NnNSaWt5NWtad3dyVTByaTcvbkZNTmN2ald3TzYxR3VraFMzM0ZoZmJZb2I4?=
 =?utf-8?B?T3lVeHdzc3FUVjZkRjBTU1BtL1hZb0pZOVpDRUM4SVlqdnJEc2xCRWdHNnFr?=
 =?utf-8?B?VytMc3JRa082YjdlK0IvWnBZUGdMeGhVK3l4aGIvOFFvY3Y3OHpBT1h6dVRU?=
 =?utf-8?B?UEZJaFZFTmVmTXh1c2FXeWI5N1BRUjlrUHJPRXpYWWF6aEhsdzBvbTlRSmhS?=
 =?utf-8?B?SHNHZVFMK0F1cWo0SHhQYitNSHFRQXdmYjc3NFBqYjJ1RUxZS2wyWjB3azY5?=
 =?utf-8?B?TGwzM2ovd2p0N2J3bVV0MmkrREhzV29Td3l0VURUa3NVVFUvRlZpYnM5NmMv?=
 =?utf-8?Q?qZOy7FRyqtvfg7miz4Yupb+3WFzzu4+3QTzolPtRnE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB4A6A22FF65EC4A839BFFFF3CF19FE0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SHBhQUY2MGErRDhVaC9kekRnUWdIL3dRendZbzVzb2hiczNuMmxTaG9xak1p?=
 =?utf-8?B?NG4zd0h6R0UwRm5iU3k3VGpETFhWUExPMkFYOHJHUk1VdjBsQlhWS2kwV1R5?=
 =?utf-8?B?NzZVSXhUa0J2SlFEb0czeC9JS2VIdmh1bW0xNTNEam4zWm85VGtoblJGa1lS?=
 =?utf-8?B?UDZ5THpaTHRpV2M2dDBXZExZSlRERDJNZ2VhM3JiTnowR0ozNnZ5VkRlK2xY?=
 =?utf-8?B?UWFUNzJoRzloQWlIbGhqNWRCWjVBTk9CV3RMQndXWUVTOW1jNGd0ZnVJNGp5?=
 =?utf-8?B?MDI0WmRsNXRsdFdEL2lhaEk3TnF5ZCtxcGNMNUlZaTYxUkxydDY1bmRGTk5i?=
 =?utf-8?B?YjlDemhESk43eXFCQzhSWjU4TzdOWVUwM2lkdkI5UDkwcjBZVit6ZkRxeEZq?=
 =?utf-8?B?eldZeGEzNjRpdE9rby84UFpFNTZObnMwWU5uT1ZJbEtzNDVKM0VnZFhoOFB2?=
 =?utf-8?B?dGRWQW9JSUFEV3dXRFlOUzN6c1NrQ1NTeFUrM0lPVStqVVAwLys5ZE45YlRO?=
 =?utf-8?B?Yi9NVEdPSkY2V09FZEtLUWcxcXJBbjdyclM2R09uOExCc1p0TlhhRWVqVmRj?=
 =?utf-8?B?a0p0YWlldXhtWHNHeHROTXZ4cFFMa0RTSy9pbkRhOEFSME5GUWtVQkFDRG1U?=
 =?utf-8?B?Rm9Ua2tCdkk4azlUSmVQRE9kUldjRU9KNjY4UHFQdk1zUnpsckVUakdaVm5F?=
 =?utf-8?B?UWt6cHhCREUrQjQ2dGtXTERMREx1NnZacGFTTGszSVZidlpUb0tzc3lsSUlx?=
 =?utf-8?B?VkxuVmJMT04vZkRyeXpKQTBScUhxaXNJeUd4a0U0K21OdEgvM2RYWUtBc3N3?=
 =?utf-8?B?TnA0bTJrUEZNNEtZQkZma1VpYjMwTGpQQ1hySm9GN1BaSTFsK21vTXVVOTRz?=
 =?utf-8?B?bXAwcDJnYzVMcHVjcW9nMU5XNS9WbWtqQ3lyTndiSnVZVm5LTzM3bXVuZS9B?=
 =?utf-8?B?czU1azhETlpiT1M3N3oraTRycGJjbkt2TFBTWVJpS1VnWGJjN2JXSTQ2dFJp?=
 =?utf-8?B?QXQ0K1g3NlZmVXl4c3FBeTRjb3NXQS8yU25TdFpuMVZpZ1VIRHlMTjFDR2sz?=
 =?utf-8?B?bE5aQ3I0WXk2NnFucCttUUwrSlJOR0lFbWF1c0NySktKVkNuQkdBM1BNdlB1?=
 =?utf-8?B?UncwcXlZSU1kdmFHcjhwWHNXcm5VSTJVME1tRldmR2RaeHNhZC8wNUY3MWhE?=
 =?utf-8?B?TnhmcTRIbElKQ1JVZ25MOUNyNGpyZ0N5RG9xTzZ6Ry9rNVJzS1ZobVZ1MENB?=
 =?utf-8?Q?M3KKWkQLfyeQZEO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b83bcd6-2b96-4500-e12d-08db8d2ef035
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 16:48:14.0609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vLqbFHtOJ22jlF4dWd51U5fIMnAJHqLuBgt/rFBF4XWD85hai3iWNKYDERPoOGgiFgiVNXDj/ysKDyN+NVvYnNrnGqRUFIevl6Em9WpFo/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_08,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250146
X-Proofpoint-ORIG-GUID: 9_mdUbPPFlMsXKHVZ9PSeYxoY5qx6s9W
X-Proofpoint-GUID: 9_mdUbPPFlMsXKHVZ9PSeYxoY5qx6s9W
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,URI_NOVOWEL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gT24gSnVsIDI1LCAyMDIzLCBhdCA2OjA1IEFNLCBOYXJlc2ggS2FtYm9qdSA8bmFyZXNo
LmthbWJvanVAbGluYXJvLm9yZz4gd3JvdGU6DQo+IA0KPiBzZWxmdGVzdHM6IGNvbm5lY3Rvcjog
cHJvY19maWx0ZXIgYnVpbGQgZmFpbGVkIHdpdGggY2xhbmctMTYgZHVlIHRvIGJlbG93DQo+IHdh
cm5pbmdzIC8gZXJyb3JzIG9uIExpbnV4IG5leHQtMjAyMzA3MjUuDQo+IA0KPiBSZXBvcnRlZC1i
eTogTGludXggS2VybmVsIEZ1bmN0aW9uYWwgVGVzdGluZyA8bGtmdEBsaW5hcm8ub3JnPg0KPiAN
Cj4gY2xhbmcgLS10YXJnZXQ9YWFyY2g2NC1saW51eC1nbnUgLWZpbnRlZ3JhdGVkLWFzDQo+IC1X
ZXJyb3I9dW5rbm93bi13YXJuaW5nLW9wdGlvbiAtV2Vycm9yPWlnbm9yZWQtb3B0aW1pemF0aW9u
LWFyZ3VtZW50DQo+IC1XZXJyb3I9b3B0aW9uLWlnbm9yZWQgLVdlcnJvcj11bnVzZWQtY29tbWFu
ZC1saW5lLWFyZ3VtZW50DQo+IC0tdGFyZ2V0PWFhcmNoNjQtbGludXgtZ251IC1maW50ZWdyYXRl
ZC1hcyAtV2FsbCAgICAgcHJvY19maWx0ZXIuYyAgLW8NCj4gL2hvbWUvdHV4YnVpbGQvLmNhY2hl
L3R1eG1ha2UvYnVpbGRzLzEvYnVpbGQva3NlbGZ0ZXN0L2Nvbm5lY3Rvci9wcm9jX2ZpbHRlcg0K
PiBwcm9jX2ZpbHRlci5jOjQyOjEyOiBlcnJvcjogaW52YWxpZCBhcHBsaWNhdGlvbiBvZiAnc2l6
ZW9mJyB0byBhbg0KPiBpbmNvbXBsZXRlIHR5cGUgJ3N0cnVjdCBwcm9jX2lucHV0Jw0KPiAgICAg
ICAgY2hhciBidWZmW05MX01FU1NBR0VfU0laRV07DQo+ICAgICAgICAgICAgICAgICAgXn5+fn5+
fn5+fn5+fn5+DQo+IHByb2NfZmlsdGVyLmM6MjI6NTogbm90ZTogZXhwYW5kZWQgZnJvbSBtYWNy
byAnTkxfTUVTU0FHRV9TSVpFJw0KPiAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2Yoc3Ry
dWN0IHByb2NfaW5wdXQpKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBeICAgICB+fn5+fn5+
fn5+fn5+fn5+fn5+DQo+IHByb2NfZmlsdGVyLmM6NDI6MTI6IG5vdGU6IGZvcndhcmQgZGVjbGFy
YXRpb24gb2YgJ3N0cnVjdCBwcm9jX2lucHV0Jw0KPiBwcm9jX2ZpbHRlci5jOjIyOjE5OiBub3Rl
OiBleHBhbmRlZCBmcm9tIG1hY3JvICdOTF9NRVNTQUdFX1NJWkUnDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgIHNpemVvZihzdHJ1Y3QgcHJvY19pbnB1dCkpDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXg0KPiBwcm9jX2ZpbHRlci5jOjQ4OjIwOiBlcnJvcjogaW52
YWxpZCBhcHBsaWNhdGlvbiBvZiAnc2l6ZW9mJyB0byBhbg0KPiBpbmNvbXBsZXRlIHR5cGUgJ3N0
cnVjdCBwcm9jX2lucHV0Jw0KPiAgICAgICAgICAgICAgICBoZHItPm5sbXNnX2xlbiA9IE5MX01F
U1NBR0VfU0laRTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+
fn5+fn4NCj4gcHJvY19maWx0ZXIuYzoyMjo1OiBub3RlOiBleHBhbmRlZCBmcm9tIG1hY3JvICdO
TF9NRVNTQUdFX1NJWkUnDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihzdHJ1Y3Qg
cHJvY19pbnB1dCkpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIF4gICAgIH5+fn5+fn5+fn5+
fn5+fn5+fn4NCj4gcHJvY19maWx0ZXIuYzo0MjoxMjogbm90ZTogZm9yd2FyZCBkZWNsYXJhdGlv
biBvZiAnc3RydWN0IHByb2NfaW5wdXQnDQo+ICAgICAgICBjaGFyIGJ1ZmZbTkxfTUVTU0FHRV9T
SVpFXTsNCj4gICAgICAgICAgICAgICAgICBeDQo+IHByb2NfZmlsdGVyLmM6MjI6MTk6IG5vdGU6
IGV4cGFuZGVkIGZyb20gbWFjcm8gJ05MX01FU1NBR0VfU0laRScNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgc2l6ZW9mKHN0cnVjdCBwcm9jX2lucHV0KSkNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBeDQo+IHByb2NfZmlsdGVyLmM6NjQ6MTQ6IGVycm9yOiBpbnZh
bGlkIGFwcGxpY2F0aW9uIG9mICdzaXplb2YnIHRvIGFuDQo+IGluY29tcGxldGUgdHlwZSAnc3Ry
dWN0IHByb2NfaW5wdXQnDQo+ICAgICAgICAgICAgICAgIG1zZy0+bGVuID0gc2l6ZW9mKHN0cnVj
dCBwcm9jX2lucHV0KTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICBeICAgICB+fn5+fn5+
fn5+fn5+fn5+fn5+DQo+IHByb2NfZmlsdGVyLmM6NDI6MTI6IG5vdGU6IGZvcndhcmQgZGVjbGFy
YXRpb24gb2YgJ3N0cnVjdCBwcm9jX2lucHV0Jw0KPiAgICAgICAgY2hhciBidWZmW05MX01FU1NB
R0VfU0laRV07DQo+ICAgICAgICAgICAgICAgICAgXg0KPiBwcm9jX2ZpbHRlci5jOjIyOjE5OiBu
b3RlOiBleHBhbmRlZCBmcm9tIG1hY3JvICdOTF9NRVNTQUdFX1NJWkUnDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIHNpemVvZihzdHJ1Y3QgcHJvY19pbnB1dCkpDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiBwcm9jX2ZpbHRlci5jOjY1OjM1OiBlcnJvcjog
aW5jb21wbGV0ZSBkZWZpbml0aW9uIG9mIHR5cGUgJ3N0cnVjdCBwcm9jX2lucHV0Jw0KPiAgICAg
ICAgICAgICAgICAoKHN0cnVjdCBwcm9jX2lucHV0ICopbXNnLT5kYXRhKS0+bWNhc3Rfb3AgPQ0K
PiAgICAgICAgICAgICAgICB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fl4NCj4gcHJv
Y19maWx0ZXIuYzo0MjoxMjogbm90ZTogZm9yd2FyZCBkZWNsYXJhdGlvbiBvZiAnc3RydWN0IHBy
b2NfaW5wdXQnDQo+ICAgICAgICBjaGFyIGJ1ZmZbTkxfTUVTU0FHRV9TSVpFXTsNCj4gICAgICAg
ICAgICAgICAgICBeDQo+IHByb2NfZmlsdGVyLmM6MjI6MTk6IG5vdGU6IGV4cGFuZGVkIGZyb20g
bWFjcm8gJ05MX01FU1NBR0VfU0laRScNCj4gICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9m
KHN0cnVjdCBwcm9jX2lucHV0KSkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBeDQo+IHByb2NfZmlsdGVyLmM6NjY6MzE6IGVycm9yOiBpbmNvbXBsZXRlIGRlZmluaXRp
b24gb2YgdHlwZSAnc3RydWN0IHByb2NfaW5wdXQnDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
KChzdHJ1Y3QgcHJvY19pbnB1dCAqKXBpbnApLT5tY2FzdF9vcDsNCj4gICAgICAgICAgICAgICAg
ICAgICAgICB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5eDQo+IHByb2NfZmlsdGVyLmM6NDI6
MTI6IG5vdGU6IGZvcndhcmQgZGVjbGFyYXRpb24gb2YgJ3N0cnVjdCBwcm9jX2lucHV0Jw0KPiAg
ICAgICAgY2hhciBidWZmW05MX01FU1NBR0VfU0laRV07DQo+ICAgICAgICAgICAgICAgICAgXg0K
PiBwcm9jX2ZpbHRlci5jOjIyOjE5OiBub3RlOiBleHBhbmRlZCBmcm9tIG1hY3JvICdOTF9NRVNT
QUdFX1NJWkUnDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihzdHJ1Y3QgcHJvY19p
bnB1dCkpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiBwcm9j
X2ZpbHRlci5jOjY3OjM1OiBlcnJvcjogaW5jb21wbGV0ZSBkZWZpbml0aW9uIG9mIHR5cGUgJ3N0
cnVjdCBwcm9jX2lucHV0Jw0KPiAgICAgICAgICAgICAgICAoKHN0cnVjdCBwcm9jX2lucHV0ICop
bXNnLT5kYXRhKS0+ZXZlbnRfdHlwZSA9DQo+ICAgICAgICAgICAgICAgIH5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+Xg0KPiBwcm9jX2ZpbHRlci5jOjQyOjEyOiBub3RlOiBmb3J3YXJk
IGRlY2xhcmF0aW9uIG9mICdzdHJ1Y3QgcHJvY19pbnB1dCcNCj4gICAgICAgIGNoYXIgYnVmZltO
TF9NRVNTQUdFX1NJWkVdOw0KPiAgICAgICAgICAgICAgICAgIF4NCj4gcHJvY19maWx0ZXIuYzoy
MjoxOTogbm90ZTogZXhwYW5kZWQgZnJvbSBtYWNybyAnTkxfTUVTU0FHRV9TSVpFJw0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICBzaXplb2Yoc3RydWN0IHByb2NfaW5wdXQpKQ0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4NCj4gcHJvY19maWx0ZXIuYzo2ODozMTog
ZXJyb3I6IGluY29tcGxldGUgZGVmaW5pdGlvbiBvZiB0eXBlICdzdHJ1Y3QgcHJvY19pbnB1dCcN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAoKHN0cnVjdCBwcm9jX2lucHV0ICopcGlucCktPmV2
ZW50X3R5cGU7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgfn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+Xg0KPiBwcm9jX2ZpbHRlci5jOjQyOjEyOiBub3RlOiBmb3J3YXJkIGRlY2xhcmF0aW9u
IG9mICdzdHJ1Y3QgcHJvY19pbnB1dCcNCj4gICAgICAgIGNoYXIgYnVmZltOTF9NRVNTQUdFX1NJ
WkVdOw0KPiAgICAgICAgICAgICAgICAgIF4NCj4gcHJvY19maWx0ZXIuYzoyMjoxOTogbm90ZTog
ZXhwYW5kZWQgZnJvbSBtYWNybyAnTkxfTUVTU0FHRV9TSVpFJw0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICBzaXplb2Yoc3RydWN0IHByb2NfaW5wdXQpKQ0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIF4NCj4gcHJvY19maWx0ZXIuYzoyNDU6MjA6IGVycm9yOiB2YXJp
YWJsZSBoYXMgaW5jb21wbGV0ZSB0eXBlICdzdHJ1Y3QgcHJvY19pbnB1dCcNCj4gICAgICAgIHN0
cnVjdCBwcm9jX2lucHV0IGlucHV0Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiBw
cm9jX2ZpbHRlci5jOjI0NTo5OiBub3RlOiBmb3J3YXJkIGRlY2xhcmF0aW9uIG9mICdzdHJ1Y3Qg
cHJvY19pbnB1dCcNCj4gICAgICAgIHN0cnVjdCBwcm9jX2lucHV0IGlucHV0Ow0KPiAgICAgICAg
ICAgICAgIF4NCj4gcHJvY19maWx0ZXIuYzoyNjQ6MjI6IGVycm9yOiB1c2Ugb2YgdW5kZWNsYXJl
ZCBpZGVudGlmaWVyDQo+ICdQUk9DX0VWRU5UX05PTlpFUk9fRVhJVCcNCj4gICAgICAgICAgICAg
ICAgaW5wdXQuZXZlbnRfdHlwZSA9IFBST0NfRVZFTlRfTk9OWkVST19FWElUOw0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiA5IGVycm9ycyBnZW5lcmF0ZWQuDQo+IG1h
a2VbNF06IExlYXZpbmcgZGlyZWN0b3J5ICcvYnVpbGRzL2xpbnV4L3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2Nvbm5lY3RvcuKAmQ0KPiANCj4gDQpUaGVzZSBhcmUgZXhwZWN0ZWQgc2luY2UgeW91
IG5lZWQgdG8gaGF2ZSB0aGUgY2hhbmdlcyBpbiBrZXJuZWwgdGhhdCB3ZXJlIGNvbW1pdHRlZCB3
aXRoIHRoaXMgcGF0Y2ggdG8gYmUgaW5zdGFsbGVkIG9uIHRoZSBrZXJuZWwgb24gd2hpY2ggdGhp
cyBpcyBiZWluZyBjb21waWxlZC9ydW4gb24uIFRoYXQgaXMgd2hhdCB0aGUgdGVzdCBpcyBmb3Is
IGFuZCB0aGUgY2hlY2sgdG8gbWFrZSBpdCBydW4gb24gcHJldmlvdXMga2VybmVscyBhcyB3ZWxs
IHdhcyBtYWRlIGEgcnVudGltZSBjaGVjay4gRG8geW91IGV4cGVjdCB0aGlzIHRvIGNvbXBpbGUg
b24gYSBrZXJuZWwgd2l0aG91dCB0aGUgY29ycmVzcG9uZGluZyBrZXJuZWwgY2hhbmdlcyB0aGF0
IHdlcmUgY29tbWl0dGVkIHdpdGggdGhpcyBwYXRjaD8NCg0KQW5qYWxpDQoNCj4gDQo+IExpbmtz
Og0KPiAtIGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3N0b3JhZ2UudHV4c3Vp
dGUuY29tL3B1YmxpYy9saW5hcm8vbGtmdC9idWlsZHMvMlQzNjc2SHBLMjQzZ01CTFlKQ3A0T1hE
bVdsL19fOyEhQUNXVjVOOU0yUlY5OWhRIUtHcE5MTmdGOVRCMURpNnZuc0lCS2dqUWJxWXlnaFVx
ZU5yNHE0eE1sMHVHZXNZT05aN2g1R2wyNnZVTDYyblZ0LTlZVEptaXlFNmN3VU03c0FqQVdZSVZL
Wk5Ldk1ZYyQgDQo+IA0KPiBzdGVwcyB0byByZXByb2R1Y2U6DQo+IC0gaHR0cHM6Ly91cmxkZWZl
bnNlLmNvbS92My9fX2h0dHBzOi8vc3RvcmFnZS50dXhzdWl0ZS5jb20vcHVibGljL2xpbmFyby9s
a2Z0L2J1aWxkcy8yVDM2NzZIcEsyNDNnTUJMWUpDcDRPWERtV2wvdHV4bWFrZV9yZXByb2R1Y2Vy
LnNoX187ISFBQ1dWNU45TTJSVjk5aFEhS0dwTkxOZ0Y5VEIxRGk2dm5zSUJLZ2pRYnFZeWdoVXFl
TnI0cTR4TWwwdUdlc1lPTlo3aDVHbDI2dlVMNjJuVnQtOVlUSm1peUU2Y3dVTTdzQWpBV1lJVktT
ZlFLYnpLJCANCj4gLS0NCj4gTGluYXJvIExLRlQNCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92
My9fX2h0dHBzOi8vbGtmdC5saW5hcm8ub3JnX187ISFBQ1dWNU45TTJSVjk5aFEhS0dwTkxOZ0Y5
VEIxRGk2dm5zSUJLZ2pRYnFZeWdoVXFlTnI0cTR4TWwwdUdlc1lPTlo3aDVHbDI2dlVMNjJuVnQt
OVlUSm1peUU2Y3dVTTdzQWpBV1lJVktZbHdsTE9LJCANCg0K
