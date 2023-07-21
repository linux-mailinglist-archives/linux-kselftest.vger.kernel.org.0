Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181EB75D129
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jul 2023 20:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjGUSQE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jul 2023 14:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGUSQC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jul 2023 14:16:02 -0400
Received: from MW2PR02CU002.outbound.protection.outlook.com (mail-westus2azon11013010.outbound.protection.outlook.com [52.101.49.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B9B2D4C;
        Fri, 21 Jul 2023 11:16:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LroHHHDEKWgMIAN4qcQ0s6k4eaBoAYRlFvuBxUB+U4Twx/hLodNPH7452fWsg+lTlWAmRT3PLFxAYAw3e/Z8ET/VGiLDKrDNVzxEN4Xa1UDJxS3L+jY88gghKmM8j5Zz6c09wvs/iCyhNLyM9krMQIxHlyZAzXQ5PkxFJG/8Nec1Q7XBGfwgyMGEF9cgKT+/vSpX4B7iS8ka5oo43XEW0dHcpv5bfQjuAcNlmSszRWjFrqmLyQJUqKopFvIFhwyBTTONXWbjvPpGGz4z39L4LyJWC2eyIXtw6DhmW0IMXYGfHhbpF1/ujYpIkOSKGGea1Yvpc287339wt5KKNgJqjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuaYdPhlhzktyg0kW53rS+aJMpwJ194mHIcpT+uSocA=;
 b=SSBr4966XC0JxYFg7ElnS5jOfnbNbYTncf3L/wjuzFLne2H1I+ErMwkG9284dQwDbiWhyljuciJZe7bJpXPDJNIc9fPMPqNTffhcZH/NoivBEiU9adv2Lwd2jh2s8m9msxnXy8O+oAxu8bBCNG71phrWj32snKXsF7/3VFjLRevGI6oXJX3dHCN/howc3ocPTgpj3Bxs8iTOiTUkqvDNTYDY7DB/5gB5Ipb4q4LAsq6/mcaqckXlsAzjaJLjCCacqPYGJrK5cchwgfBbfuTZV73VERuhS2XYxHjXf/d7BDXDw4iwlHLMEJikimn6xYT2K/lZN4q/QbRLya8zFKRe6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuaYdPhlhzktyg0kW53rS+aJMpwJ194mHIcpT+uSocA=;
 b=yp6J5KzwRkl+r4Ksg+FkdF/E4mLIS3DmwIYLz/OjQp0EEWfUC/VFnNcGrshodnc6N0ewRqpStSCqMf/StpYUskEm8/PFsnZAiwf2y7wH9y2OBVJ/ID29pk6ziQoEEd/yEsYd42qtzYYjndq/PZErISd1z0sLGZkF9+lksHMffwY=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by CH3PR05MB9580.namprd05.prod.outlook.com (2603:10b6:610:14d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Fri, 21 Jul
 2023 18:15:58 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::92ad:8382:ae15:59a9]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::92ad:8382:ae15:59a9%7]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 18:15:58 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Valentin Schneider <vschneid@redhat.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Chuang Wang <nashuiliang@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Petr Mladek <pmladek@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>,
        Julian Pidancet <julian.pidancet@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>
Subject: Re: [RFC PATCH v2 20/20] x86/mm, mm/vmalloc: Defer
 flush_tlb_kernel_range() targeting NOHZ_FULL CPUs
Thread-Topic: [RFC PATCH v2 20/20] x86/mm, mm/vmalloc: Defer
 flush_tlb_kernel_range() targeting NOHZ_FULL CPUs
Thread-Index: AQHZuygc2EqEnKJbqk2MRjNS6hbswq/EiG2A
Date:   Fri, 21 Jul 2023 18:15:57 +0000
Message-ID: <188AEA79-10E6-4DFF-86F4-FE624FD1880F@vmware.com>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-21-vschneid@redhat.com>
In-Reply-To: <20230720163056.2564824-21-vschneid@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|CH3PR05MB9580:EE_
x-ms-office365-filtering-correlation-id: 59c252e6-1ff8-4754-19a0-08db8a16881c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cwhAaEE72WeGhalf9IjrMCAqqyJ5IG3ocg1iongIR3SApwlPLWO875LS92WdAwMO7JZVahsc3DJ2ZjmHmCZ+JSUJo9+sK+OGEMgc0+gXTGvVLUJEa/ufZVdB0k4xTrI1uGPJr6sMvRVjoDUni9ii9KHb4YtV5KES+fBnS3qyG2k1cC8MuqSMFnuiwYF/zC1QMRRuqHB+Eqo75vp7/QXDHVwpGlmDzm2QtpTyebUXTPz4XAl6hEaQc8n4z3TPuJFye7fQCtORGaWH+pfSyzLusCEULVSP+PSIYrHn9KbMyLH1g+o7PSxqq4Doup187XjcnaL6Wki3HnbIU2OdOVd1S2Cb5EnVeXlNRgn//5vkfIkUrrnnEqFuaVum24pUgHxhT0f5ZDtrNiseddaM1zwgOrZheCVwZ/h1WV1aaeIiuKyYkJ8nFGxRjez47xzdr/TbiLPqksZT8yfwUI2bDc650z6W5MSEyGPB2am1G83JhRU5LQeOGxVLlddIrpUPr6sfkwdso7e/GhWrkGrLsLrwlGY5fs9HlY+Wk7LNC9vpMpgMJVAjX2GBESQ/CI+JN73FX9z+b/6zOPVaWIrdSAhiNBj1ND56Gjy1MRHL7kvIYsxxforR4p2ZOSURkl/Pbl9QvLFpWlsHo0OCx+EO/bnDmVtwJfNpWDVGrA7VW8N2ac5GWdSnq4TjWuyCjJSDf6wu0dBLppsWhqBtWHFW8bpsi9nqFQjw+06J1KnNZFmD4Ew=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199021)(316002)(41300700001)(66476007)(4326008)(64756008)(6916009)(66946007)(5660300002)(66556008)(66446008)(8936002)(8676002)(966005)(33656002)(83380400001)(2616005)(86362001)(38070700005)(122000001)(38100700002)(76116006)(26005)(186003)(6486002)(6506007)(36756003)(6512007)(54906003)(53546011)(478600001)(71200400001)(7416002)(7406005)(7366002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVZyUzE1RnQzWW1DY1BJK0lsdHBma2FIYXU3bVU2TW0rUDhBTXBwem1BQmZB?=
 =?utf-8?B?cU1VejBCdEQxcSt4ZFZEZ0l3c3ZsR0NqczZvVjBKdW5vYjlJLzkydlZhbTFq?=
 =?utf-8?B?L1Ntb3A3YlcyTU5IcHRTSVFrNDhRcWcvb0hrMmROVmo4QndqYXl2R28yNDQz?=
 =?utf-8?B?TmJHeVgyQjVscTJaNWtxeU5XNXFIaXJtdlpEQlU0NE9pNVZvK09TVnVLanVi?=
 =?utf-8?B?TExZT2xnZEJLMGNQNGdjUHdYWGUzRHFWeTJWZ0ZYWTFqbWR4dnVhcDJ2K0dI?=
 =?utf-8?B?ZkNWcDVpK3VxNFlIYVVsMVI3VTZGczNvaVBvYTlqNmtjSThiM1RxRHQ2Nkk4?=
 =?utf-8?B?QkNmbWQvUTBpbjQyNjVJenpqSERWQ1FHOTY3MmZVblpZVDNyajN5aSt3eVBw?=
 =?utf-8?B?SGJUK3RwMGtGL2pGbVJNU2tjZXJ3NHQyQW04ME42UmVmZ2xEWWMzUXRENGFH?=
 =?utf-8?B?RDRUYU9oR3Flbmd4b050bUdTNGFSR3QxeGVxQzE4T2NDaDhzaExYS1B6bnZi?=
 =?utf-8?B?U280bGVvNGIrM3V6d2NrSzY1N2hqVzRsY3RncU9rd0Z4RWR3ZXZrS2pKSjBz?=
 =?utf-8?B?eHN2dmlBV1NVNUtFaG1qTFFnMFA4ZzUvNXZZbXpDVnJHamNTd2pXNCtOZjhM?=
 =?utf-8?B?WWFYNHcwYm54N2M4c3ppZWRkS3h4a2VIU1FqK0xPbnY4TnBlaFByUTFVbndZ?=
 =?utf-8?B?MDRQWVY1YlBiblNCWE5vQVJhMnFDT3ZVTzFOdXV6ZGZDbi9kYXBKaC9FL3hv?=
 =?utf-8?B?aWZKS2ZkNnBTMml3eFlYeHk2bzBuRXhLaS9kbVpCN2tpelJPVUlUVzkva0Fi?=
 =?utf-8?B?eXp0SjBjY0RDemtBWTcxMUU0cS9hUlFhcG53cWZteS9vTmFRcC9FdENuZGRE?=
 =?utf-8?B?cnVVNXdXYnZCNEx5WWtqYXV1d0RXTmN1Y2k0R2s2dnhIMlA3R3hoUFltVzhP?=
 =?utf-8?B?bmhQR3BvTGRPdGg1K3NKaHRQRFByZjAzTDFtdmhLY0hFck9DOC90UU4yV0Z6?=
 =?utf-8?B?V1pub1ZTNENJVzhlTVlTMGd6a2pDNFBjbjJrU3l6MWVUUnU1cDFsc0J4QUJF?=
 =?utf-8?B?dHpuWjBKS005Ti93Nm1jcXN0RjRiS0UvVjVSc0hVY1R0YkRxZ0xLaFh6N1Rh?=
 =?utf-8?B?TVpsSld6L2tkRFdzYUx4V1MzT3N2dlVVeE9ySzVQVnV0bkJIZlFaZVh4bHds?=
 =?utf-8?B?dVJKWHE0YngwQitpMVB4YXRmU1FZRWQ4VTJZZDJ1cnMxM1laTDNmWTIvMm9Y?=
 =?utf-8?B?NjhqZnQ0cXNLQW5CZnBweWlMOEJ5eS94eXVWVXplSllPdnNHM1k5RUpPRjNp?=
 =?utf-8?B?QjBhZUNsYmo3ckcvR1IveVV1bFNFb0s1enFZTkdvbVlyREdqazN1N2dkalpp?=
 =?utf-8?B?ajhSR3FXVlo2U1lzc0RTY1BneGhJc2grQ09rMUp1TUNJbGgyRDhJdWVLWitY?=
 =?utf-8?B?VEgvLzJOczJSSENVeEhrQ3c5T2xwdFFsSE52dTNqN2gyTG1VWjI1MHAvaDhT?=
 =?utf-8?B?ckFyMTR2T1hhMzhxaGp4VDhIUDlsclJNVU5UNHhZZExwdzg1clRBb1NzTWdR?=
 =?utf-8?B?cUVidTUrdUE5ejNSRzVTdjNqRzdVRXdFS0x4d3dCd0RmZlJ1K3VybDh2RU5a?=
 =?utf-8?B?L1I3dWJsK1BHM0ZoVDNDODVaU3daejVPaHE0NVY0ekE0cG9ZbXljMFZsN3ln?=
 =?utf-8?B?RTlLZWxyRjJZbjBocDFoVFFCZHJTQVZPZXcvU3RKcUNhRGYvbWxWemRoUGZp?=
 =?utf-8?B?WGRMQk5ZVHc1bnUxeVpkOWdtTThLZkdEZng3dS96RHFUNysyL0hJZFFRMUpZ?=
 =?utf-8?B?U01uUkhOc29aTEUyMkN2MzM1UmVpaGhYbEN3MkZtcnVzZWxuRWtKdExqL2Vm?=
 =?utf-8?B?cGNTU3V4bzJrMmVyTnJjTllxT1JhZ3B5L284QkNpK1BjOHJ4WUdGL0pXOUcv?=
 =?utf-8?B?TVBXNnhlaCtodHQyZ0R1dXdETVJXMHQ3WS9wZ0Z0RlMrcGh1cS9FL09OYzg0?=
 =?utf-8?B?WUtFNFl2dER4c2FkemFIb2RjSWtqTVR4Tkl4ekpZbkVsR2ZGdUZ5OEpEUWdm?=
 =?utf-8?B?eTNFc1R1aEhFdmxUTkN2aXhtRit2RVZBY1B0bHpRU3JEcEdxc0phNmxTMGxD?=
 =?utf-8?Q?H/gpo18tl5TUkKlYenFmqLhLt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7766A4269FAF454CB9966780F5A51F95@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c252e6-1ff8-4754-19a0-08db8a16881c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 18:15:58.0227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0rdCcokAB1aG4MfPkmZNtscOZlXbH6rJCiF+1bqovADrr7naEPMhKOzgGfGuY+9rdDY9Hjf+XOHA2SUCyt0sOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR05MB9580
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gT24gSnVsIDIwLCAyMDIzLCBhdCA5OjMwIEFNLCBWYWxlbnRpbiBTY2huZWlkZXIgPHZz
Y2huZWlkQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gdnVubWFwKCkncyBpc3N1ZWQgZnJvbSBo
b3VzZWtlZXBpbmcgQ1BVcyBhcmUgYSByZWxhdGl2ZWx5IGNvbW1vbiBzb3VyY2Ugb2YNCj4gaW50
ZXJmZXJlbmNlIGZvciBpc29sYXRlZCBOT0haX0ZVTEwgQ1BVcywgYXMgdGhleSBhcmUgaGl0IGJ5
IHRoZQ0KPiBmbHVzaF90bGJfa2VybmVsX3JhbmdlKCkgSVBJcy4NCj4gDQo+IEdpdmVuIHRoYXQg
Q1BVcyBleGVjdXRpbmcgaW4gdXNlcnNwYWNlIGRvIG5vdCBhY2Nlc3MgZGF0YSBpbiB0aGUgdm1h
bGxvYw0KPiByYW5nZSwgdGhlc2UgSVBJcyBjb3VsZCBiZSBkZWZlcnJlZCB1bnRpbCB0aGVpciBu
ZXh0IGtlcm5lbCBlbnRyeS4NCg0KU28gSSB0aGluayB0aGVyZSBhcmUgYSBmZXcgYXNzdW1wdGlv
bnMgaGVyZSB0aGF0IGl0IHNlZW1zIHN1aXRhYmxlIHRvIGNvbmZpcm0NCmFuZCBhY2tub3dsZWRn
ZSB0aGUgbWFqb3Igb25lIGluIHRoZSBjb21taXQgbG9nIChhc3N1bWluZyB0aGV5IGhvbGQpLg0K
DQpUaGVyZSBpcyBhbiBhc3N1bXB0aW9uIHRoYXQgVk1BUCBwYWdlLXRhYmxlcyBhcmUgbm90IGZy
ZWVkLiBJIGFjdHVhbGx5DQpuZXZlciBwYWlkIGF0dGVudGlvbiB0byB0aGF0LCBidXQgc2tpbW1p
bmcgdGhlIGNvZGUgaXQgZG9lcyBzZWVtIHNvLiBUbw0KY2xhcmlmeSB0aGUgaXNzdWU6IGlmIHBh
Z2UtdGFibGVzIHdlcmUgZnJlZWQgYW5kIHRoZWlyIHBhZ2VzIHdlcmUgcmV1c2VkLA0KdGhlcmUg
d291bGQgYmUgYSBwcm9ibGVtIHRoYXQgcGFnZS13YWxrIGNhY2hlcyBmb3IgaW5zdGFuY2Ugd291
bGQgYmUgdXNlZA0KYW5kIOKAnGp1bmvigJ0gZW50cmllcyBmcm9tIHRoZSByZXVzZWQgcGFnZXMg
d291bGQgYmUgdXNlZC4gU2VlIFsxXS4NCg0KSSB3b3VsZCBhbHNvIGFzc3VtZSB0aGUgbWVtb3J5
LWhvdC11bnBsdWcgb2Ygc29tZSBzb3J0cyBpcyBub3QgYW4gaXNzdWUsDQooaS5lLiwgeW91IGNh
bm5vdCBoYXZlIGEgc3RhbGUgVExCIGVudHJ5IHBvaW50aW5nIHRvIG1lbW9yeSB0aGF0IHdhcw0K
dW5wbHVnZ2VkKS4gIA0KDQpJIGFsc28gdGhpbmsgdGhhdCB0aGVyZSBtaWdodCBiZSBzcGVjdWxh
dGl2ZSBjb2RlIGV4ZWN1dGlvbiB1c2luZyBzdGFsZQ0KVExCIGVudHJpZXMgdGhhdCB3b3VsZCBw
b2ludCB0byBtZW1vcnkgdGhhdCBoYXMgYmVlbiByZXVzZWQgYW5kIHBlcmhhcHMNCmNvbnRyb2xs
YWJsZSBieSB0aGUgdXNlci4gSWYgc29tZWhvdyB0aGUgQ1BVL09TIGlzIHRyaWNrZWQgdG8gdXNl
IHRoZQ0Kc3RhbGUgZXhlY3V0YWJsZSBUTEIgZW50cmllcyBlYXJseSBlbm91Z2ggb24ga2VybmVs
IGVudHJ5IHRoYXQgbWlnaHQgYmUNCmFuIGlzc3VlLiBJIGd1ZXNzIGl0IGlzIHByb2JhYmx5IHRo
ZW9yZXRpY2FsIGlzc3VlLCBidXQgaXQgd291bGQgYmUgaGVscGZ1bA0KdG8gY29uZmlybS4NCg0K
SW4gZ2VuZXJhbCwgZGVmZXJyaW5nIFRMQiBmbHVzaGVzIGNhbiBiZSBkb25lIHNhZmVseS4gVGhp
cyBwYXRjaCwgSSB0aGluaywNCnRha2VzIGl0IG9uZSBzdGVwIGZvcndhcmQgYW5kIGFsbG93cyB0
aGUgcmV1c2Ugb2YgdGhlIG1lbW9yeSBiZWZvcmUgdGhlIFRMQg0KZmx1c2ggaXMgYWN0dWFsbHkg
ZG9uZS4gVGhpcyBpcyBtb3JlIGRhbmdlcm91cy4NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xrbWwvdGlwLWI5NTY1NzViZWQ5MWVjZmIxMzZhODMwMDc0MmVjYmJmNDUxNDcxYWJAZ2l0
Lmtlcm5lbC5vcmcv
