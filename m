Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0933467A53F
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 22:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjAXVwq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 16:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjAXVwo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 16:52:44 -0500
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Jan 2023 13:52:43 PST
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53322D47
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jan 2023 13:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1674597163;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CLLgl4aCn8DORk0pVLUFq5+aBjBkSJCX/GFq5h3Td3w=;
  b=Rcf3NHpkW1+RQHOvfVKdoW9Pj7H3hEv9rHCB5j5ZUsUDfgri8ADZczbE
   Kjc2sz1SFlRVODkso8rF1SA7Uq7QTwf63D0wVuXfkT4ySaMfl72jCzDUg
   RYIe3zNniCQfUJRswqvzfSm9bTBZCBmrWrkeayI3to+7BS1XLxh9Ip+Do
   s=;
X-IronPort-RemoteIP: 104.47.58.103
X-IronPort-MID: 93518873
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:9JcIBanfUpCrMiq56tXiCQ/o5gxdJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xJJCzrVaa2PNmL3eo92btiw8U4BuJaAz4NjSAFv/CBnQSMWpZLJC+rCIxarNUt+DCFhoGFPt
 JxCN4aafKjYaleG+39B55C49SEUOZmgH+a6U6icf3grHmeIcQ954Tp7gek1n4V0ttawBgKJq
 LvartbWfVSowFaYCEpNg064gE4p7auaVA8w5ARkPqgS5gOGzBH5MbpETU2PByqgKmVrNrbSq
 9brlNmR4m7f9hExPdKp+p6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTbZLwXXx/mTSR9+2d/
 f0W3XCGpaXFCYWX8AgVe0Ew/yiTpsSq8pefSZS0mZT7I0Er7xIAahihZa07FdRwxwp5PY1B3
 aREJR1WYC+zvOGZ5Z+CZMlehOMsDfC+aevzulk4pd3YJdAPZMmbBonvu5pf1jp2gd1SF/HDY
 cZfcSBocBnLfxxIPBEQFY46m+CrwHL4dlW0qnrM/fZxvzeVkVw3ieC2WDbWUoXiqcF9t0CUv
 G/ZuU/+BQkXLoe3wjuZ6HO8wOTImEsXXapDT+Dhpq412zV/wEQxAkQydEOZjMClgxKbVvxmK
 HwZ/Q4H+P1aGEuDC4OVsweDiG6FuEVaX9t4Eusm5QXLwa3Riy6ZHmEsXC9db8Zgv8gzLRQ6h
 gGhnN7zAzFr9rqPRhq1+r6KoHWyMC4OIGkqZCkYQA9D6N7myKk/hwzCCNZqFrW4iPXxGDft0
 3aLqjQzg/MYistj/7m0+UDvhzOqu4TTSQg09kPbUwqN5Bl2aZS+e6Sn7FHa6bBLK4PxZlCEu
 XEelcGf/uFUJZ6LiTOATe9LG6umj96AMTvThnZ1EpUh/ijr8HmmFahI7S1zPlVBM8AKYzblb
 Ubf/wRL6/d7J3u3ZK9fYI+rDckui6/6GrzNU/HSYd1mYZVrcgKDuiZ0aia4233xl2AvnLs5N
 JPddtyjZV4ZCL5myD7wXOcAzbIuwT4WwWLVWIC9zhK73L7Yb3mQIZ8BMV2TfqU6966ArhnY6
 Mp3KcSH0VNcXff4by2R9pQcRXgANVAyAZH7rZwReuPrCg5nHnwxTvzc27Usf6R7kKlP0OTF5
 HewXglf0lWXuJHcAQCDa3QmZLaxW5969Co/JXZ1ZQ3u3GU/a4Gy6qtZb4EwYbQs6O1ky7hzU
 uUBfMKDRP9IT1wr5gggUHU0l6Q6HDzDuO5EF3DNjOQXF3K4ezH0xw==
IronPort-HdrOrdr: A9a23:mevjsqMjT0CzfMBcTvWjsMiBIKoaSvp037BL7TEJdfUxSKalfq
 +V7ZEmPHPP6Ar5OktQ/exoSZPwIk80nKQdieJxAV7IZniAhILHFvAF0WIg+VHd8u/Fm9K1GZ
 0OT4FOTPvNMGNXpezapDOVNOtI+qjkzElgv4nj80s=
X-IronPort-AV: E=Sophos;i="5.97,243,1669093200"; 
   d="scan'208";a="93518873"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jan 2023 16:51:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOEIQJaY68u0mheSTaZXSE8hQAq2hciReMIo9SloBXIbGm+mkeI4cyNF4KJ+lAIgDhFXjOLAPLDG1ghtJg60vkHuvkDY+RVUVWNnUXgB6hsGeF6o4Y/p9Cvow+EyyWSxjxHRS/2QMGxCNWqyz5BYfOTAHYFrQCdmQHwgcjV4gDCRtJGYYDJF9VOFuCMtxwEW8Mbu1IIJTUMlzqpBW01EASSB56Ex1ZwfdrevIdq6NjsSlE+RzyrTZVj0rlIIs9UrcRR93bREeLSU80WvRmUUPz8jCNez6iBTHKv3XYj9+YSqFmIabr4nToKho4qaBL6JcUvsrQfdAxMd+ioEBujAHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLLgl4aCn8DORk0pVLUFq5+aBjBkSJCX/GFq5h3Td3w=;
 b=KNaRctMk70JQmPcXbUMD4q31RXHwxq5SoDh4HQhdK+1EI5Ds5DAO7Kxn7CMVHj0QSfS8NL7dm2URKvTJb74/PzXisnMLZK/pCIcy42s9Vi5wtVM0LwjaYRl1Qu9gY5swqnyIwE7Uawjo4a4YTQY1gqeOOVtVskoseVxAyx4ou4eijkjQwKtn5+bS5hrkvQeRirargVeBtb0KZ5HEruHNb8OvWa/ADyFWzQ61TkVdZlq/6rHWZFOI971pNInH4lC+PQ8ddXbkhBA8s9jEpagJc0aGa9QI1e27GNZDSaXk9LmparWEH8XSvuMCWrcZcZ3fBY8dOdcEoYIurTTvq95LtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLLgl4aCn8DORk0pVLUFq5+aBjBkSJCX/GFq5h3Td3w=;
 b=eO1fZYcO6bAWSzfOYYmfj8ly1nJGXxn30FKpnlNBh8pNbR3yIox12UunY/NB8T/nbAVcnszS9TFUeE3PgNVn+zXnDBtpPCTi9MmVYKwZUWCxug0tOWth16S7froByLFbGUgGMHmlt5l73DgRMJc9CzzXaqTCHJbah1Itonwyb8Q=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by PH0PR03MB5910.namprd03.prod.outlook.com (2603:10b6:510:33::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 21:51:36 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8%7]) with mapi id 15.20.6043.017; Tue, 24 Jan 2023
 21:51:35 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     "Li, Xin3" <xin3.li@intel.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86 Mailing List <x86@kernel.org>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [RFC PATCH v3 0/2] selftests/x86: sysret_rip update for FRED
 system
Thread-Topic: [RFC PATCH v3 0/2] selftests/x86: sysret_rip update for FRED
 system
Thread-Index: AQHZL9v9G5IXJSihJUafFqAlyrLA8K6uFu4AgAAFZwA=
Date:   Tue, 24 Jan 2023 21:51:35 +0000
Message-ID: <e48a7629-f357-ed3c-9f43-b1499930ceff@citrix.com>
References: <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com>
 <25b96960-a07e-a952-5c23-786b55054126@zytor.com>
 <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org>
 <6cd0db14-c9e2-3598-fd10-4b473d78c373@citrix.com>
 <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com>
 <20230124022729.596997-1-ammarfaizi2@gnuweeb.org>
 <20230124022729.596997-3-ammarfaizi2@gnuweeb.org>
 <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com>
 <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org>
 <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com>
 <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org>
 <20230124100926.637335-1-ammarfaizi2@gnuweeb.org>
 <SA1PR11MB6734CA3184183E490D18CA72A8C99@SA1PR11MB6734.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB6734CA3184183E490D18CA72A8C99@SA1PR11MB6734.namprd11.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|PH0PR03MB5910:EE_
x-ms-office365-filtering-correlation-id: 4548c096-9fb3-42e3-11c2-08dafe5529d6
x-ld-processed: 335836de-42ef-43a2-b145-348c2ee9ca5b,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tWYx38WNj4aWY5+jdt8X8KH72AtrPkIaKPlQxFf7WN0Sfg5Eq56p/mhbqR4mYaTF3KyIoZ/H+J7dr2McT2uByrUCJ9IIjXRIMi7ddq5KPC5QiPZc3DpVUfFvHJz9UYjzHeFE2PwXktfkbAS/wmIfn0gLW7a5oL6nwYkt72dLGZS8HCGCgxgtDmG5Ah1LEnIp8ZXy3wp7pBIopfERyXpWRiB5N5XPEh5biFvu+XtCm/zsCszyY5M/GDuee4kI1WVKYg2TC1GWrcAX/OS3NVGWuGx5Ayo9k0TQqe3/1C2Wg7rxP0B2YKefln+2Zzh4anZqLseAW4K6DInJVa/qc5jlBMDcjMHGPkM0x/Yspl7YhIM1nYXpO+EIQNnRi+A4D5ome0lfhuSRzkG/8487AFej9nXqdEhO0cKwPDKeio+o13dwC/8bGkh8d9vFteP3/kQJUWl95gFbNcllRBnVWrCzhfSRK6GIC6Dhqq9Fq0idb0iGRnC16//wRgcd7HaXsOfO1phOxeLL4SIyqndTPOgTJrGESg0Enp19H830zZ8rN594ic6yrCOjck60CwHHQCRU/8Ufk2gIDmbQTudoLsv4DWZ+5bJeyI7izNurGDdmS1fvQuOX1dTpq4VcFvUlSjGRNJsBt2GHqKw65OU2ngrZNcJXKhZSWGmrqBHPUxtlrS1jmHDsbBwuIo4CwgTqRmPFMbbTR/wVtgyFnl9rDmJyRYbgD1ujEEjy3D+P+3+7VXyDWlPcUrXZ7MA/HF5Zfjg2wCtYlEcQOSX7hjG6FspPfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199018)(41300700001)(316002)(110136005)(54906003)(91956017)(8676002)(76116006)(66946007)(64756008)(4326008)(66446008)(66476007)(53546011)(66556008)(86362001)(478600001)(107886003)(186003)(83380400001)(26005)(6512007)(71200400001)(36756003)(6486002)(2616005)(31686004)(38070700005)(7416002)(4744005)(5660300002)(82960400001)(122000001)(2906002)(31696002)(15650500001)(38100700002)(8936002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NE4wZWdyRDRZZHdPazdIR05jdCtxSUZpYUJTd0hJeTZPU0hmcGlUVVg1dml3?=
 =?utf-8?B?VWdrQ3B6c3lXSHI0QnFqYnE2UUZTa2ZSVTdaWjZpL3NRMTcyYlJXa2ViK09v?=
 =?utf-8?B?VitmUEwvQ1libDJmVTVVb1dWdC9uTVJPdEJiSis1cC91eFNZdHpFbUM1d0lV?=
 =?utf-8?B?Vk1yenhQMXNNSDB5bGxJc3E5NmRnOG81bktHMXJiREl2ZVd4dis4aXFxL2Vl?=
 =?utf-8?B?aVU2RGVXT05KWkNqb1lGVDg5Z2plM3Y1QTFiaHB2VjA2dDNqSUlONFhOWk02?=
 =?utf-8?B?Z1p0MUlaL2dPTjdnUjllcmJuOUkzYWZBYjVWRVB3Sy9ZUjEwZDFycHRSbDFQ?=
 =?utf-8?B?MzJYVThNV1p4Sk1ia2JPZDVOL2krdWlueFpEV3FJWWhtZGI3UmZLbTBkRGdt?=
 =?utf-8?B?L0FYQjFtNlRVSUxMZVg0VHNzVkRTeDQxbjNIMUZIeG9yZmx3cmNiQTFsY0dL?=
 =?utf-8?B?RDJmQ0VKWklWTW51WE5YY0haZlRJbEF5SUR3TEtNOWR6a1JmR0d6NDRCbGg2?=
 =?utf-8?B?VjhjdlI1YUVONHNsa2lZSWxBMWRwOTNZU24xSW5leTVmOEpUY2hxWWFnaHd2?=
 =?utf-8?B?aEVTS2ljRFMxMHY1YUJObytLaW44SCt5NklMWEVWL3hOMlpHSnBiK01pN05L?=
 =?utf-8?B?dloySWV3cHUvT241SFl0WHdKekNFQ2phV1VFd2RrdWp1T0c4c1cvNHNLc0My?=
 =?utf-8?B?aFpBL3lndDRmc1BzM2Y3bnloSUhQU2NORVF3Y3ZBV1plK0NGMEMyNnRlZjdV?=
 =?utf-8?B?UmV3UW5TcXlqL2dYK01HS2NUM1cveFArUVhwUmU5WW1SbjdnN0hlZmtRTm4r?=
 =?utf-8?B?c1p3UC9TUldHMjBxaU1nM1h4SXVRNVU5MjhkQ0ZZSVB2VzA2ZGw3OU9SM0NQ?=
 =?utf-8?B?b1RJL1lkSHlmVzk5ZnF2Y0RKVmppU016R2lHUEdsYkVtaUgwOUhZZUUvL3FZ?=
 =?utf-8?B?Z2QzeXpDTXFETUhsVkUrV0VtOVFJYngvZ09OS09DOHkrUzMrTWZZRXJ5Q244?=
 =?utf-8?B?TzBxNlIyaWplVVZrZ3JxcFRQMU9zaGxtMlJSanlhUDZQYmMxVjN5UEtUYVR3?=
 =?utf-8?B?dUI3RWtzR3VMdG1wRmZJcGM2dWRKOEU0ck0vZHdNMkZnOE9XNjJFczVQZmJB?=
 =?utf-8?B?NDMrRFMyZXV0eVBGUDdvcUU4akVnRWgyRkZQUVJFbW14aVZEUnJPRWpIb2ds?=
 =?utf-8?B?blpsdDFaQy9EWG1tbXkyZlhNZVJWODlQcEpjOXVJVXlRcGs5cms2aEJCMTll?=
 =?utf-8?B?ZCtWcGVCSjNvTFJ2Z0hGcVJxdzlYMEFGWFd1VjhCb0tnOTZBTm9kbm9uUGp2?=
 =?utf-8?B?dW9iNENEcTlxTHA5Qko4c0doYnpVUlFFRjQ3WmNzeEptVmhCMkFJSDFtTHZq?=
 =?utf-8?B?QVkxelg5dG1JYjc2YXdmTndsZzhpWlA5clVsTXgyOHprT1hYSGFBN3ZTemFO?=
 =?utf-8?B?bFdpV0Zkem5xa2ZqU01KMStsWFVwTVpmNlZRcDB4SW10SGR2VjZFdkVoeGhV?=
 =?utf-8?B?TldHV2NmYkVSTXgrUzRQYXlGR29HaVpzaitFMFpZUmdzcXAvS0doVlpUaDEz?=
 =?utf-8?B?cW9vclJUYXNud2l2TmFxTk1QTkI0WWVsam9uNFUxZWlaQmlnNVFlVUNpVWRq?=
 =?utf-8?B?S3hNYTJkLzZwdWdDcis5TlZTVXV4VEllNjI5RDkxWTA0bGhUSnZ0RGhUeE40?=
 =?utf-8?B?M3l4K1pmbEtXRUhKUzVLeUJkWllkK2x6UFpTMGIvcmg3cDMyZjNqdUk5Wk4y?=
 =?utf-8?B?bXhhUGdFYlprTUxYVWVQSmEzaTE4U3NtZ0VyMjc4T1FQQWVzMjVVM3JGYTF4?=
 =?utf-8?B?aXc4SWFwMytMUVRqUTFTWkZEeWRqRnBhMXR4SDFIcGdzWGVqRWhLelhXa2hn?=
 =?utf-8?B?KzhNdDBUMkJGdCsvb1NFOHp2WkplWkNIVkZFaVZLQVNMbitHNlE5RzNtWXJ4?=
 =?utf-8?B?dTVhU3RmSXJoSno2c09PdWhFQkZncDIydHpTQy9qQjFDSVcrMytYdTM0WEt2?=
 =?utf-8?B?UXdEMkZPK0N1MFkzOEg4OFhUTGFWeXJFbTZoMnJ5YjNGeHZaaXRINFhhallH?=
 =?utf-8?B?aGZoWXVlUDdWK1dmbW8wekFYNVhPRksveXRUakExbUVYZDNza0pJdWZyZGYw?=
 =?utf-8?Q?Ps2MmO1WTZDUNXm1tEUul4HW4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E70C50AE7FD6B84BAFF0864F96FC5E52@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cUNkNkRKd1lLcHRNNUJSUTY2L205Rks1M013V2psZWJ0N3BPR0NwY25nd3py?=
 =?utf-8?B?ZDlDQmdBTkR6RFZvN2l1MDljL01KeVExd29MYUN6S2dXTmxXcjNrU3MwZlNG?=
 =?utf-8?B?ME9NNWJtK3hGeWlyM2NONExUemxLc3JrRldTSENmcmcrVzVlQmtoajdQRXNB?=
 =?utf-8?B?YUdyM2VNM2dvajYxWHJpVmFHVmhTTGpXWHE5ZEp3NS9MR2ZTUFBSbHpuOG5k?=
 =?utf-8?B?OHE2cHd1SHQ2QURMK1pkRHBtVVM5NDRVWHdmVmpzaFNkTVBQTjFmY0lSSXRU?=
 =?utf-8?B?N3MzSTJYYWpnUWllQzdPdU9OZEFkQUtIekFvdnpJOHlVRUhFbHZ6aUZhaTB4?=
 =?utf-8?B?RlQzNmJQc3MwdndnNWRDU1poYUtzdnB6YnFBcUMvQTFpZ3NQVlF5blFseTh4?=
 =?utf-8?B?MGtkemJzNHB3cDEyQ3BUTTdkWTg0bnZZbzFYQVkzdWk2R1gxWldCc1F3NXJF?=
 =?utf-8?B?SkhuaDc5TGFTTlJaM1BWNnFyeDR5dFhveXJVVEk4Z0xQcDNqcFZJUTViSUJW?=
 =?utf-8?B?bWx2eCs2WTM4UGFzeG5PZkRMY01hV0srSHdtRVVSUjZSQkNzaGJuaTUzMExL?=
 =?utf-8?B?ekh5U2NFT3JxVVVCZEpyU2dZQjA3Sk9tUkxXR0wycWxlbWhPUlJpUE5CUjky?=
 =?utf-8?B?S0FiZ1pxbHRBbjZZTzNKOWlHNVFMVDJuOXdtNDBpaUpyOTZzRTdCWXhsZzVk?=
 =?utf-8?B?cmNWVjllY0tpY2N0OVFibThFdUloVnl5MGFkSUl4MEZ4N3BOU0RhZXFLVGVv?=
 =?utf-8?B?ekxjM1Bpd0ozL1hLNFp2MHFuMVFsVnZhNGM3ZDdpWXFyK083UkVPT2ZGNFpW?=
 =?utf-8?B?NldiRExsN2JrRmJWeWlHak5mTUpMaEZtbVNpQmUzbEtSQ3pIK3lYSnpJUTlh?=
 =?utf-8?B?SmtvS1RMRy9SM3RrL3BzVlRmOVdlT1FnRjhMOVJOOXJibXlTWHZtN1czZDds?=
 =?utf-8?B?RWtpZDdVNDVodmVteURKQitJZDNCN2xRN0p6QjkzeE9GZXd1MU1WU1pNNjgw?=
 =?utf-8?B?RmpTSG9hNTBtOGFtejBkRlZBUC8wWEVianhaamh2T21NK2NxTEVDd252VExT?=
 =?utf-8?B?OGo1Tmx3OG1xSzR2U05SVUU5K3gySzR4YVl0QWxWaENZemVlL2pJc2JoVGwy?=
 =?utf-8?B?cjVrSnFodHVSUmUvZlE0UWlmUXJJUkJEL2JRRktjWHE3Q3pKaUt5UlY2a3M3?=
 =?utf-8?B?NXdyOXYvbXdMaTEwSHhyaldLZVBUTHNVUS9GTXhzNG1pK2dSMWkvMWdCNWpq?=
 =?utf-8?B?cWpwaURrd2VqL21zVStnREZFbkgrNWFEU096OEovWWFSbGtZK2VtVFh5dW5N?=
 =?utf-8?B?eklPVGh1dTBtQW9Idm5MK0hGbGtHUXJ6cGR2eit1UUxDcC92VElyMC9lMEp6?=
 =?utf-8?B?dllFdDZGelI0OHAvYlpwV21Ub1kycTJxU2tqTWtzTlZnQ2kxYXdaWUlwWEMw?=
 =?utf-8?B?cU9UWE5JVFRYU2JqMWN5WnA3ZzRyTlpYdXhEUkF3PT0=?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4548c096-9fb3-42e3-11c2-08dafe5529d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 21:51:35.3291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bDPFuRLZK3J5rXmC2UkjgQLIjKcRC0ItGycvSALppHTg1lA6EhGOZtUtukvLOvI3nacumBM9/9q44fVWE5rJXYg6YharM2EOA5XPRM409CY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5910
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gMjQvMDEvMjAyMyA5OjMyIHBtLCBMaSwgWGluMyB3cm90ZToNCj4+IEZyb206IEFtbWFyIEZh
aXppIDxhbW1hcmZhaXppMkBnbnV3ZWViLm9yZz4NCj4+DQo+PiBUaGlzIGlzIGFuIFJGQyBwYXRj
aHNldCB2MzoNCj4+IHN5c3JldF9yaXAgdGVzdCB1cGRhdGUgZm9yIEludGVsIEZSRUQgYXJjaGl0
ZWN0dXJlLg0KPj4NCj4+IFhpbiBMaSByZXBvcnRlZCBzeXNyZXRfcmlwIHRlc3QgZmFpbHMgYXQ6
DQo+Pg0KPj4gICAgICAgICBhc3NlcnQoY3R4LT51Y19tY29udGV4dC5ncmVnc1tSRUdfRUZMXSA9
PQ0KPj4gICAgICAgICAgICAgICAgY3R4LT51Y19tY29udGV4dC5ncmVnc1tSRUdfUjExXSk7DQo+
IE9uIEZSRUQgc3lzdGVtcywgZmxhZ3MgaXMgMHgyMDBhOTMgYW5kIHIxMSBpcyAweGZlZWRmYWNl
ZGVhZGJlZWYgaGVyZS4NCg0KSXMgdGhpcyB1bmRlciBTSU1JQ1MsIG9yIGVsc2V3aGVyZT/CoCBJ
dCdzIGRvdWJseSB3ZWlyZCB0aGF0IGZsYWdzLyVyMTENCm1hdGNoLCBidXQgJXJpcC8lcmN4IGRv
bid0Lg0KDQp+QW5kcmV3DQo=
