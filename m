Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABA36979DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 11:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjBOK3z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Feb 2023 05:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbjBOK3x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Feb 2023 05:29:53 -0500
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB9D366A3;
        Wed, 15 Feb 2023 02:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1676456991;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iyj1YAjzrdTAUyvN3UbPE4Yu7QKTrAypoqZeVPt00do=;
  b=ZCruXLUuB4d1/D+aE4FZBgE4wCbhs6xPQr8tss3I7ON6yUWRzHSB4SdV
   Y3gVXF7rZQhixYgJf2vB7HMWlnkPo+I4dMWBgQDCOyNtDlK/YX29PxTBk
   vOPUNoD/ngCsPKoTKRYdLTPLz7CJgqSDFOjWdspvdKvMwy9e1LDROrBDS
   o=;
X-IronPort-RemoteIP: 104.47.70.104
X-IronPort-MID: 99540375
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:NPclua1JM/C8I21SB/bD5eJxkn2cJEfYwER7XKvMYLTBsI5bp2dTy
 zdOUWiGOqzeZzSkfN5zOd6x/UkDuZCAxtU1TAs+pC1hF35El5HIVI+TRqvS04F+DeWYFR46s
 J9OAjXkBJppJpMJjk71atANlVEliefTAOK6ULWeUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tq3qMDEULOf82cc3lk8tuTS93uDgNyo4GlD5gZnOKgS1LPjvyJ94Kw3dPnZw0TQGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRrukoPD9IOaF8/ttm8t4sZJ
 OOhF3CHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqFvnrSFL/hGVSkL0YMkFulfADFzq
 qMFcyA2dA2h2e63xeOVRcUviZF2RCXrFNt3VnBI6xj8VK5ja7acBqLA6JlfwSs6gd1IEbDGf
 c0FZDFzbRPGJRpSJlMQD5F4l+Ct7pX9W2QA9BTJ+uxouy6KlFAZPLvFabI5fvSjQ8lPk1nej
 WXB52njWTkRNcCFyCrD+XWp7gPKtXKqBd5KT+LlnhJsqESszFcfVB1Hb1C6pvfjlVS6ePAFL
 ENBr0LCqoB3riRHVOLVVhi9qWSKtx8OWoB4HOsn9wyAwOzT+QnxLmgcRxZTecAhrok9QjlC/
 lOAgd6vBTVpq7CTYXOb6rqQ6zi1PEA9IWYcaGkERA0e7t/LpIA1kwKJT9B/HarzhdrwcRnzw
 iqLqCx4nLUOkcMO0LuT+VHBniLqp57VQwpz7QLSNkq54QdpTIqkYZG081/d7OYGIIvxZkGMo
 HUeieCf6u4UBJ2AnSDLR/8CdJmj/fmIKibAqVFqFpglsT+q/haLd5h46TV/KUE5dMoJERfyY
 FLauStS6YVVMX/sarV4C6q0CsIlyoDjGM7jW/SSacBBCrB1aROA1CJjf0id2ybqikdEubFvZ
 7+YfNyqAHJcDr5opBKyRuEAwfoo3S06y3/eXozT0Ruqy/ydaWSTRLNDN0GBBsg97aWZsEDW/
 sxZOs+i1RpSSqv9bzPR/IpVKkoFRUXXHrjzos1TM+SFfQxvHTh5D+eLmOt9PYt4g65Si+HEu
 GmnXVNVw0b+gnuBLhiWbndka/XkWpMXQW8HABHA9G2AgxALCbtDJo9GH3frVdHLLNBe8MM=
IronPort-HdrOrdr: A9a23:TlH7w676jAyfdm/2EgPXwZ2CI+orL9Y04lQ7vn2ZFiYlEfBwxv
 rPoB1E737JYW4qKQ4dcKO7Sde9qBLnhNJICOYqTMyftWXdyQ+VxcRZnPffKl7bamLDH4xmpN
 1dmsFFYbWaZzUX4qiKgnjcLz9j+qj7zEnCv5a5854Zd3ATV0gW1XYBNu/0KDwQeCB2Qb4CUL
 aM7MtOoDStPV4NaN6gO3UDV+/f4/XWiZPPe3c9dlAawTjLqQntxK/xEhCe0BtbeShI260e/W
 /MlBG8zrm/ssu81gTX2wbontVrcZrau5t+7f63+4oowwbX+0OVjUNaKvm/VQUO0aKSAZAR4Z
 7xSlkbToJOAjjqDxCISFPWqnndOXAVmibfIJuj8CHeiP28fhZ/DdZdi4RYdRWx0Tt5gPhMlJ
 hum3icv4FLDBXbgU3GloP1fgAvnVGzpXo/laoWlXJeXOIlGcxshJ1a80VPHJgaGiXmrIghDe
 l1FcnZoO1baFWAchnizyJSKfGXLz0O9y29MwA/k93Q1yITkGFyzkMeysBalnAc9IglQ50B4+
 jfKKxnmLxHU8dTNMtGdao8aNryDnaITQPHMWqUL1iiHKYbO2jVo5qy5Lku/umldJEB0ZN3kp
 XcV1FTs3I0ZivVeIez9YwO9gqITHS2XDzrxM0b759luqfkTL6uKiGHQEBGqbrXnxzeOLytZx
 +eAuMjPxa4FxqdJW9g5XyKZ6Vv
X-IronPort-AV: E=Sophos;i="5.97,299,1669093200"; 
   d="scan'208";a="99540375"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 05:29:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/6eIGMKoRFkgM7XO08qwK3nHLOWm9mH3rix/UOFo8T/cnIZaS1dPMKjGH9vGR25+rHm46wByczE045sH5UU4bhOxbvL1oo2B1ojtranF2xJcMHrMaRZO7kISqppuqcermTlfHplAK6e4zSg0qb/NtNWL7FyTV2GqwHvwrsxygUChFS6f3Tk8eRXm89IiwUetr/CM0X/sDdHB1z9jxfFVo3cq9p0aJ6v7JEyEMA6HlZpeoWhCnkpmPQUh+MZtjrEeRM8eoieRFU3D7ieWK1REKovJQ2UAinRcV1xmupaFn9pv/fVdBBq/jMNxp0xOWLY9UohAlIwx9y5g63hY7CrtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbAndK7eFK3IX6k0nhZ+jr/+8wBHRc286UQX3Q7o6iw=;
 b=YpX1AwbAKncmw9RV8UMShfMdPpIEONaWsoH19da6Zj9Fkux6xrSWSqMNiFp/zcfBdJODcHXMTPdZdUWwMJF/NCioq5qtGPvisv9ENDwf6DE0CjVZO31TcPJ1xIgiZWOcYSk/Y8nCFIzs1IeYSZYJIXO8AehDJehpWu3/5YYXNBZpcaquXIzCw94MpG9nIzzUha3R+x7d7tMFC+4mmOGvETVzrphEpS5bBpLSQPIJk47dYCrAXbuF91xgGlRBJKU+KfGRTyk8D85qbgH9bEb7vLYlb4n56ayJ0vS+mds7zYl0Wxc5msTgK/F0eCZWCqQVFTmUTC2EG3kP6nlBSin/sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbAndK7eFK3IX6k0nhZ+jr/+8wBHRc286UQX3Q7o6iw=;
 b=gkTBNhkHBl6qjjlgioSjlgj2umYKPX85TprcRz3fLehHACR/BvT5znjbYIhLUHrNxE5qN3p4ICILepCwY4PlPtYmVXwnYB/dGy/N7LCO2i1W4OjsceRtwIj0ES3DTNRb4tnSG5GghaaLnWCtxpGxEIILrnRfsfJvUDMbGHdWs6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SJ0PR03MB6422.namprd03.prod.outlook.com (2603:10b6:a03:396::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 10:29:46 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8%7]) with mapi id 15.20.6086.024; Wed, 15 Feb 2023
 10:29:46 +0000
Message-ID: <e4222762-fc60-a848-09af-f6de614d5f74@citrix.com>
Date:   Wed, 15 Feb 2023 10:29:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH v1 1/2] selftests/x86: sysret_rip: Handle syscall in a
 FRED system
Content-Language: en-GB
From:   Andrew Cooper <andrew.cooper3@citrix.com>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Shuah Khan <shuah@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        x86 Mailing List <x86@kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <SA1PR11MB673498933098295BFC7C2900A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com>
 <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com>
 <25b96960-a07e-a952-5c23-786b55054126@zytor.com>
 <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org>
 <F554C5FE-5074-410A-B0B5-EFE983D57946@zytor.com>
 <Y88bhrDoPw5tOyKu@biznet-home.integral.gnuweeb.org>
 <509443c8-e0fd-935f-63d8-7264f5dd3c05@zytor.com>
 <20230124002625.581323-1-ammarfaizi2@gnuweeb.org>
 <20230124002625.581323-2-ammarfaizi2@gnuweeb.org>
 <8f5c24df-514d-5d89-f58f-ec8c3eb1e049@zytor.com>
 <Y9LdwVX9BaZA7zmA@biznet-home.integral.gnuweeb.org>
 <0b57d2ab-14e0-14a0-adf3-3186fd2f5282@citrix.com>
In-Reply-To: <0b57d2ab-14e0-14a0-adf3-3186fd2f5282@citrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0352.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::15) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|SJ0PR03MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: 99af46bd-5643-4ee4-01d9-08db0f3f8eb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jNH7IVRviqhqRWc6ZiUMXScudZd8N3lnz9v2f/C/lEHjJQbpnuqNq2vJZ9PCW/h2XOF3DhAsw5Y9lfk3tus7aYT4l/qrQMXcvjirehnAPnKHXOYkzoSUKWK+4NDMga+AEfmuPkrtBBA3+VU7LSCuXagbqwNxgyiAvE74c81nIzFE8U+2tJke4SH6PpvSkoONkP5V/Ni9suT0iAkzGwTcLNV7RSrsiEiPhJgtU45EOCRuQDRJIzekVlpBkel8p+T57+bHErsV480Bx+9vPR4zR3NM6dJW6/DdDvKLI1CAJgLx23OcUHKgOtvYrGXxiQqHXMHO1ehjuxLqds1Y9M0fR56Kf6+fvKlIWMykGaDsMK8oSpOHvNqYFC8c/eogxkzZv1lByAuP8Hoi70BiHKFizqX90wtGKBDN8mQ2trs8e2KouIpydTssZhCq5l5QHdclrEdoGvsYNEPiCzdLnn7RcL6c5eA0UsCcuDARf98zBmzSUtDj14puyiml7H5JzD/0GgOVbI1bHdotb0RNwSXHS6wXr49blT6/LYSTUx4YaPRweqEv0YSo6Wi9yavQMDNA9KgAjHBCjpEBFFn7lqn6f3zJWcSIaCsxzKFSILXRDOFSY2c3SJjsFVGLtX//1wFvbpGR80tVfjzwHe1xWHUOyiAc3m1UtDJsfHXNaFc9xJzMY45J+LsvMTeZ5scBEbYTbsrpe/ffSboUX280S0k4o6PwhbL/VZS9JIkQefunnnc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199018)(83380400001)(2906002)(7416002)(8936002)(41300700001)(5660300002)(36756003)(8676002)(66946007)(66476007)(4326008)(66556008)(54906003)(316002)(110136005)(966005)(6486002)(478600001)(53546011)(2616005)(31696002)(26005)(6506007)(6666004)(6512007)(186003)(86362001)(38100700002)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkFPQWc1ZGRJbGNXQ3FIdXNsVGRibjZvQUJyQ2pqWUQ3dW5oY2tqbHRBUGw4?=
 =?utf-8?B?clFYTHZaUWI4NUdSSWY2d3MvaEVuZmdtVERGK2NnSjBOM3dzQWJUWkxjcjJ1?=
 =?utf-8?B?eWl4TGpPRUQvRFF4K2NpSC9BY2ZJc1h3T2RPdzZHdkw3SE44cGhLenIwUHdG?=
 =?utf-8?B?bDh5M09UMjRkbk9zNDBzTmcvbUwxUlRicGdmakQycGRIc3RLN3V4ZEhzZVNT?=
 =?utf-8?B?ZkF3THdIM3MrdWRFKzhsZThKRFllVTBvWFg1Mm9rZXFYdTlzejUrMUlZWG5m?=
 =?utf-8?B?dzU5V0xCWTZMR0xqbDhQTmV5aERLQ1VHMjlkUDhPUVlMckIvdjNYY21tTVZ0?=
 =?utf-8?B?dDRaTW5vN3VjV2JHVlRhYTVGWXlob0FQRXpxb0U4VHBPMUVpRlBHRTA2TGF6?=
 =?utf-8?B?cjYrRFg5SDdiR0hZZ25DOUhHN1NFc2YvV0J6REFHVXlocjJpRW9oL0ZPdnVB?=
 =?utf-8?B?emVSRzlTUGtKcXBpYkRDbk54VXRaeVRKaGk0ZjZEQmFtRno4S0hHdjdEQTRn?=
 =?utf-8?B?WVlXa1JWb0RiTGpwN1ByMUZyOTBjUE0vS2NxZUlnV0ZBR004RFdJeFdIUG9x?=
 =?utf-8?B?Sk5ZWHVOb0xBeWVPbmF6UTMyQ1cyd2NZZlpNV1BJQXpnUERnMGFwTXE2VzJv?=
 =?utf-8?B?c0UxRUZHUWVRSWVqMmpYaEc5SEZEdVBYdWhYYjNxdWtMandxQ0RhcnVuZTY2?=
 =?utf-8?B?dXRCMlM4NE8wcmtEUTk1NDFRWDcvQk9Tc0ZTcXhPbTN5ZGxQMHlzaVd1cGhi?=
 =?utf-8?B?K2lnVWRZcmZpSkdMZHBjZHJuS0NjdVpsVjhibDNtN1BFZFJGV2RVWkp0aXNX?=
 =?utf-8?B?b2lzNm5GazU5UkJRelVBaUFqbHdHNlprTGVlVkMwY3ZMbzhWcXBLNGkrKzdy?=
 =?utf-8?B?NlhJRzB1a0RyN3g5dURaWVZYUEwxWGk4TXU3TUN0aXowOU9TWmM2T1hzVjdo?=
 =?utf-8?B?YUJITkM5VlFrVFVOLzluYTFKeHhzTjFhRXd0YnBVRDJIMUlrc09CRGZzOWt0?=
 =?utf-8?B?OTdvakZ5MTNxOFlLZWxoQkZheVBoeGc3RFBubzExQmpCQ1Y5Y0JtNm5xbkxk?=
 =?utf-8?B?Z3lKR1pxUitQYjFrc2pGOVlMaWQySDFWbnAyLzlmNXRNcXFXVWFvQjNFWitz?=
 =?utf-8?B?TlY1NERSRkVZcGJFRzVmR1hwcENXVzJ4ZTA4bkpNTkpKNkpDcDZxdWkxcHh3?=
 =?utf-8?B?YzRoVkJVNUJ3a2x6dXY1ZDdFdHdxTEYveUJ4VW0yUFM3SUlrMGZDc3U1UVBF?=
 =?utf-8?B?UWdFcmNKeWNoUHdhNUNYTXZDQVZ1cDRhZjB2SmgyNEtBZEE5T0VrZnFUY2xT?=
 =?utf-8?B?OVVHT3pUbmFPNFg5Y3NMU1FwQ0ptNDYzeGpLVHBucFNEa1A4emY5ZUNXQXo3?=
 =?utf-8?B?eEZ3dXJtZUF0TlhUM1IydjFabkE0VkUxK011KzFjOGRMdkxZSkxHNEp3SzlF?=
 =?utf-8?B?Tnppb0hxOElDL05xdHA3cU5PSUl2cWI4N01rV01HbDI3Q3h6OWIvYWZtOHBM?=
 =?utf-8?B?RGJsZDBRa3dBekVxWGdBVDMyV1l6TFRGeTVMMEdNL0d2SlRZYzBIaDFEUFhY?=
 =?utf-8?B?amxYTktKMUtnUU5laFJXaHhkb3BIZnZPNDh3Tm53L0tndkRMRUxlek12cTJP?=
 =?utf-8?B?V0wyT2lGTXFsbUw4M25JOVIxMkNwNzZHOThWVHp4WTlhZlJZcUlQR2t1QlJz?=
 =?utf-8?B?VnRDMk9YcTMwbDkxZkNLZUFSTVNKSUVGYjRUaUkrVzh4b1Z2OXJnVnhNL0hH?=
 =?utf-8?B?aGpzblZzQmh3SVhMOU9VcEJ0emQwVDZqdEtWeFdaM0RUdjV2M1dKZ3hoNklU?=
 =?utf-8?B?S0NsaU42L1grRlJ3Zk9KOEMrejc0MXFEM1ZtMXZoMTJIT3pjbkd5UjJwWnUz?=
 =?utf-8?B?SEp1dWNRVDYrNDhzS0NPZWJuMSt5Q09SWFpQUFo1ai9mS1JDVmdQZFJNUFpI?=
 =?utf-8?B?OWRwd1d0a0VYN3J3TzMxSm9MS2JZRWxOdU1LcFV5bk41T29Uc0xtQ2JnWnRz?=
 =?utf-8?B?N1JTK2dQbkFJMS9mRkpjOVBFM3Z4R29UT0poRHd1UDA0ZFJaN3dHNEJMWTJp?=
 =?utf-8?B?ZE5TWVNxU3krVHpIQWlXRnlHT0lvenQ0cituNWJRUkg4UVNXbm5hUmRzT1E1?=
 =?utf-8?B?dnV1KzlQbmxXeCtpRkNRc0xPUWVGenNWZW1vbXlraEwydWw3MUZ6djV5cnZs?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZU9wWU9vcmVnYVV3N1lIWjU2VE5tQVhpSlZhVFRuYVVCdXlyald5d2xDUXFX?=
 =?utf-8?B?ekZveHcrODJzZndPWWtuTXY3NnFEVzg4SW1KVjAvd3BFN21MMmxlUXFVT2dt?=
 =?utf-8?B?aXdXdjQ4cDQ1UUZyQWdYZW92U0xwd0xBTWovb0dKZ3EzZi9GS013emhhb0w3?=
 =?utf-8?B?a0gzQVdHeWE4VXdtbmRjZnY5Zk5IUG1uaERybkJDd05LdkxyQi9WdG5oNzly?=
 =?utf-8?B?MG10a0RSdEU1NzU2Vm5ESGFBQ1ZFMVUxRXFOWWNEZkxaM0pzSjhOSmM2V3lJ?=
 =?utf-8?B?MTd0M1lhYnk1MnhZVE1INkJ3SFo4d3RmT29nd1ZOeTZBU2I3M2Y5WnZremNZ?=
 =?utf-8?B?ZmdhRFJQV2x5WWd4T29EalVycVdZcldGWHlPMS9tUlEvaXhadEY5cDgzd3Yy?=
 =?utf-8?B?Nmtna1dyTFJiM1EvNy9NczlTU0ZKOXArKzQ3SnI5NjM1NkpmbWhaUjdLdFhw?=
 =?utf-8?B?a1pleVdDSHZ2ay9QZmt1UVR0T0ZsRTY0eDRwVVJRV20zUnJ0MExvN0VqeGl6?=
 =?utf-8?B?cHRhcGNsZ2M1L1JHMndZNHo3MmUrc0gxVXRmKzE2cVdRU3pzVFRoWEhsZjF3?=
 =?utf-8?B?UTdVZkJJMFgyY3NGNlZ0cFNZWWVLK0ZBZUtqSGQ4bWhxdis3dktqQ3RjRnBt?=
 =?utf-8?B?TVAyVlhZZkJid2puRUVBNHNpcXJxMnNMc1UrVDlnbThjYVRET09kaEdiWjQz?=
 =?utf-8?B?dmtFM3gvT1B5YVMvTENFSlVCa0UyZVNRc0ZRSnhWU3Y4M3E5amo4VXFFU2Fr?=
 =?utf-8?B?dGkzeTFKa0Q3bUtsZWlJamptT09VK1dZSDFVNXp3dEFMYlI0cG1JMmVkS2VU?=
 =?utf-8?B?SEU2cmlWNXhLUnpPWHRORjBVcm96c1NaeFY1WlBxVmp0RmNGWHJBNExZaWJp?=
 =?utf-8?B?cG42K2d1VmRQb3ZQeEtid3pOYW10Q3UrRW5HVUw1Wk8xaWV1Rk5qM291K0Ji?=
 =?utf-8?B?RUkxSVlYVlZPcFhoWDMrN1Z6bTR2UVQ4dlU3WnhFNDY3a1kvNVc0MmE2UTJ6?=
 =?utf-8?B?WE04NlpDc0phOFVGM0ZLdDN0MWp2TDRtVmVOVmZES1doMjVIOWpJMVZ5bnRO?=
 =?utf-8?B?L3ZPRmhyTXkrcDQ3VkkxTUJDdXZ6VmwwYmNOQUpvVGNPT25PS21sZnplamtu?=
 =?utf-8?B?cmNERi9Ramt4OEdoZnh4cDE5ZlQ1TmFubHR3MVc3eW4yTWI5bXJRZnNQaVh4?=
 =?utf-8?B?ZE01WEJnZjdFQ2x0Q2Rwa3V2U1JVa2NlejNPVWoyb2g5REUwYUJUd1U5MGJM?=
 =?utf-8?B?cEIyTG82WWZmMGhMNUoyMHNtRWttNnlWYlljengvTk9UYVNMMFdKL1RTR1h0?=
 =?utf-8?B?cGR3Tjg2VTJ2ZnBjbzZ4V0RmVStVU0hJYTkyMENDNXlmRVFwV2xnU2NJYVhF?=
 =?utf-8?Q?ZIviLZdSIsr2wrXtAbDwzcKyXOOe2akA=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99af46bd-5643-4ee4-01d9-08db0f3f8eb2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 10:29:45.7100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUUmytNjvUtWpFNmhMgud+pl6x7ITg7AZQZen1VecKmMbdCXh4Xhy59HFKwd8y7gAmGdPjfeCMAVHaf392knKxO/IHv/rwzpoJcIKle2By4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6422
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 15/02/2023 9:17 am, Andrew Cooper wrote:
> On 26/01/2023 8:08 pm, Ammar Faizi wrote:
>> On Mon, Jan 23, 2023 at 05:40:23PM -0800, H. Peter Anvin wrote:
>>> So as per Andrew's comment, add:
>>>
>>> register void * rsp asm("%rsp");
>>>
>>> ...
>>>
>>> "+r" (rsp)	/* clobber the redzone */
>>>
>>> ... as the right way to avoid redzone problems.
>> I played with this more. I found something wrong with this. This doesn't
>> work for me. The compiler still uses red zone despite I use "+r" (rsp).
>>
>> What did I do wrong?
> Well this is a fine mess...
>
> https://godbolt.org/z/MaPM7s8qr does the right thing, but is now
> contrary to the prior discussion regarding calls in asm, which concluded
> that the "+r"(rsp) was the way to go.
>
> Furthermore GCC regressed in 9.0 and emits:
>
>   warning: listing the stack pointer register 'rsp' in a clobber list is
> deprecated [-Wdeprecated]
>
> which might be the intention of the developers, but is wrong seeing as
> this is the only way to say "I modify the redzone" to the compiler...

I've opened https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108799

~Andrew
