Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED74765A6A
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 19:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjG0RfL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 13:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjG0RfK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 13:35:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CED2D5A;
        Thu, 27 Jul 2023 10:35:09 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RFOAxE023165;
        Thu, 27 Jul 2023 17:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=GWBnbWPP8hQjNlUjxFR6VkjBoyoA4iQSARX2pTuMpcs=;
 b=VS5MHy3womuhPYKgPgC4l7YGr3M23B1rQk8ifPkgyJ7oHXZJksZHzpCDcJJgnE4Xq1f4
 wAKeruSchOmAFkS1nesTAtJl3ap/iZtuz1BafMEffRcooVBuBnKhjWbIlg8ejnYEkyNb
 K5vIde6Ufvkxfx1NNCeZFdBalJCtSxZTFUqsf75jgr7mR1K/9UvBWRi+cFoijzpy7UIu
 D7c46r1mh7DTSKMpGfY0gnl3eyYXi3eBzcb+GWPisIe8CbZMoF5mxvlM2Sr4n+8rwP4Q
 XYyGqSAXgc8XqOWnyiP1XT8NEyVPW7l9wWplI1Tu9szPgIOVvu2/IkhFFJVegopfdcxH OQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s07nut8bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jul 2023 17:34:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36RGJWbQ033654;
        Thu, 27 Jul 2023 17:34:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05je8sb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jul 2023 17:34:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K36phRY+0/rcQ1hTP0v9rc4bEXKba3y9PqN+xwDRnU/ar1xdq3byGp2LGvBiZFYcReWnsKgH7lsSn9O7Ffok0WnoweQwCjQwglIj8WPKlND6bR5rvWJ1kv7uZYiS8QekizV9123/4XH0D6Qi1AdlGSBHVt/DgNlWNg/yYp5FOk4ORCkCkE7Zq5xjaSHS2tr0ukSOlWOp7PDHjBNUXPKxH0GopbHY872WXt1vWyoGKRUiKk4k8SNa3b5VjchSI/Qtx9tV0PQOou/lUYultmbfnHM6nZvnh3jaHnc/Hw4v1j6ZbHhNoHpLfJdumbZlN9tVlRTA34rl18WHvV4SdGVLqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWBnbWPP8hQjNlUjxFR6VkjBoyoA4iQSARX2pTuMpcs=;
 b=kC1PE9vUZGIc9JQ3J3IlzTBgfd3P3UAiuekZ6zUxVEyPwCtgvKy2dLih1JBdh/DvuRE4VxXegwFne/0z3Ob2VPdri4VODmCHjivadFQBqkVJCwnIAWA/fTJjtqEzC0/963/bZmAV3hTfSkNOFrWhShB0Sx+osyUqVQOATH4APz4W0GPXEbzXxagwFS/Supf1n4qIAvAY3RanhvcSa+J0n1O9C6AXQTZFsbOq6TzZ2nSiSrx8OWtAfQKSzZXyc4kGaJGm+Eq4We5FOVHbPRxtrTdg1RdgmHBbk9Te+qOQyQPFWhUxpYLPpQSntaOBvDGMMzJmlViFvVJifhBEglyfog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWBnbWPP8hQjNlUjxFR6VkjBoyoA4iQSARX2pTuMpcs=;
 b=LGc/o4gRq47FukNgI73W+catl/9FJ5PeCge5icZ+QDpPdvpFqHCIPB6UaXUEaF1KLkOLY2CbMXndeIbkYeE4rvhq7y50itTprnc3CYVcvg5n1CbhpseWKq/5jcIa0kUHt3oDUFR+7PWFQrM8OyaR4N/kiuUYiz/FndPb40Fobr4=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by CH3PR10MB7434.namprd10.prod.outlook.com (2603:10b6:610:15b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 17:34:37 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::69d6:8729:ee7c:cc45]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::69d6:8729:ee7c:cc45%2]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 17:34:37 +0000
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
Thread-Index: AQHZvvi/xI4ekXqIdU+9CLD2lWipK6/KsaiAgAMxnwA=
Date:   Thu, 27 Jul 2023 17:34:37 +0000
Message-ID: <BB43F17E-EC00-4E72-BB3D-F4E6FA65F954@oracle.com>
References: <CA+G9fYt=6ysz636XcQ=-KJp7vJcMZ=NjbQBrn77v7vnTcfP2cA@mail.gmail.com>
 <E8C72537-4280-401A-B25D-9734D2756A6A@oracle.com>
In-Reply-To: <E8C72537-4280-401A-B25D-9734D2756A6A@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|CH3PR10MB7434:EE_
x-ms-office365-filtering-correlation-id: 79f2f732-13ae-4f6e-3f9a-08db8ec7c00f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: shLJ6srNi2xwVtxyrm2nU2KcJHvzsC0lvjhhntQ/FQklQBCJk3B8TpwoO65ZiCEGR7Li4aC02RmKp9HUyNTEyEqY2/VQ23UsYVVNEZrDADKqtstGrXyYuGaFX3inqsQ0iRJMX6BmJbON5i5PXFlSFbA/EG59YkCQoMbpHZmWY50YkIz0eYOJbNoTRuessZqqHn4Vrxyz3fjB0QJVArOPCsLvenQtK/tThXgFjQXwd9xB2M0cVsEHdbfM2CGNaMg617GT2oZPtLxCFdEWPU2lRbyyDx+LijLlvQUIFxpHYQk/d9649dia91rjHGusHHP0kg3g7Adu6+ZvIJ7yYZjEshHldSMeyK5TMF5ckY0Lz6A0mQYTO81Ep4nMLU5RUVrCzNcxv/QyXCf09nb8mUUHqgb1z1xYoQFGnrZs5p9005OgRBLSRiDvGy+9Bvw3u6ZJZJe5XJm2sIbz8Fm5QlUkTRemn89aZhzA8x0t7crA/yyugiyRt6bcY//lkKCdS4YVBXP0Z3uepRVmITU+RgPtJd1g7hiKmKrMzwDbWSpBA0FpVqzDPRkqIYRya/vsqiDuGzXTHsLLXDQCO1jCYH6rrkkhIrilPz6Z/GTpjJyPee4kHRnMLM3+q575qj/c4nEJbA7GbaZCirLVSnfMOOCN2b4QWjaKPtvrl0dfkXtk6StI3qpnvN5hls6rzu/Oie+n
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199021)(41300700001)(2906002)(316002)(38070700005)(8936002)(8676002)(33656002)(36756003)(86362001)(5660300002)(6512007)(966005)(53546011)(6506007)(26005)(107886003)(6486002)(478600001)(71200400001)(83380400001)(186003)(2616005)(91956017)(76116006)(38100700002)(6916009)(122000001)(4326008)(66476007)(66556008)(54906003)(64756008)(66946007)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TG5xdTAwOHdFZ1hqbW5lbENNdmg5b0RQSFh6S21uOTRGN3U1ODRmS0RRb254?=
 =?utf-8?B?aVF6N3dGSnVSSXYzMEpOWmhHV2VSNzNTdjdlaFBhQnVXbG1lOGZiOENTL3M4?=
 =?utf-8?B?Sk1vYld3bWZ2aXg5S21yemw3blRTYndiaWVHU2Y5VWNHa3RyNExsQXJOUEQ0?=
 =?utf-8?B?ZU9RZ2N4SzRUOTdJaVorV0ZOTFJnaDlRUlBzL0srSVJtNVI4dTE3VytBUUVI?=
 =?utf-8?B?ckdNanNXN0ozNFpraEtpeDY4MkpzV3AzNVJTRFFPK0J1YmUrNS9kWHIwOTlx?=
 =?utf-8?B?ZW00dnNNTVR6elJTRDF6VnRydHRHT3M2NGRQeFlVQ0hmUlNNWWtVelhMekJV?=
 =?utf-8?B?Zko3TE5kbmFGYUFxb3BuczZoemVsVGpOc0szaWFYeWN6ekhiVDBPTmZKTndj?=
 =?utf-8?B?K1g2dXFIbHVHZ09QTDRWWkl6eVBvUVFCMFg2SjJNek9MR29nWU9wRDNvanpN?=
 =?utf-8?B?d0FwZnBQYkNjR2hYcnk0RHU2S2U1c3BhdDdneDYwWEdDbTYzTXZ3Z3p2UWpp?=
 =?utf-8?B?KytkbGE0dE0wcW83YXh6S0RUNm9KU0xMejJZNHpQSTFIeTh2U2ZNK1YvMnM5?=
 =?utf-8?B?SGNpdDhmNDBDUWlrM2NtSU1xc2M5dW1JNllrS2RZOXlrMVphTXdmVDdDbFVX?=
 =?utf-8?B?WnhOZFJ5VFNMN0ZIaXJYVXFyeWxqUkoxZk1Fd0xldERiUW50US9seFdVTXVE?=
 =?utf-8?B?V1hMM2p2Q3kxMFFiN0dtaHU4S205VnNVVEJQeWl6Z0U3SzBqVDA3Y0hKaW1U?=
 =?utf-8?B?WEZoWTdvQVlQbmlZSEt1NUYvUFQzWHFiTklPZW81Uy94K29OcFFoZHVQUWZN?=
 =?utf-8?B?ZW5BMTV3SVBtcW5oby9veS9EVFlsUzE5VSs1dU1EL2dtUzZNanZvUU5oZ0Q2?=
 =?utf-8?B?L3NycGN1OEszS0FpbWRMaVNHRnkvZGN0WFZjY0M2TDZTNE5PL2tTTnV3M2l2?=
 =?utf-8?B?cTVvVzVKa0xRc1h2YWYzdTRlRUIyend3M3ZabmVIRzBoU1Bqb05GOXpQa3NB?=
 =?utf-8?B?dkFOeFVPNEhmai9nbGptMExBMXBibjRlbTNMbXR5RTRINDRqNFA2Umtycjli?=
 =?utf-8?B?ZUNUSXBpdEx4K2Jha1haK2VlYnBGaHdUdGx0cXJKeXJvbzduQitlSFB6SjR1?=
 =?utf-8?B?Qm55eE93VDNiRGJsWExXbHcwYlprd2MyN0s1VExlWGxNeldhZFBBdTlUYWZ3?=
 =?utf-8?B?WkU3Mk1GOWpBUEpyV1lGTjlkRUp5VnIxS1NsQkYyWWZ1eUV0a3VOa3JBMUQv?=
 =?utf-8?B?RmlkVFB6czdyMjJUZUQ1ay9uNlpXNmdURVdMN2ZzMngveEJFNkpOWGxpaHRW?=
 =?utf-8?B?UFdvRWwvcnhYTGtFbi9UaXVMbEZwVXhaL01ZS0ZmdXhtZGU0RWxvRjlWbHRO?=
 =?utf-8?B?RFV4bEppWVAwYkx2MUp4Nlh2eC9KSEpLQWM5S2tPUURHbXdMZ1JhN3kybmJ2?=
 =?utf-8?B?dVlmeUpqV09VNkRudFBBYzFNSWNxYjZrUVhaaW9oUjNEcnNHdTN0NVQrV0Nx?=
 =?utf-8?B?OG81aXZQaEdZeCs1M0VVY2VWZmpZbWc4UmYvZ3hhWFB2WlRzRUdWSCtjdHFn?=
 =?utf-8?B?ZmkweGE4eTdpNmxwa1JRNjZqQTZQaFBLMUFTNTdOWmJadHMvMHRzNENGdW9w?=
 =?utf-8?B?ZmhNMnF6aU9yN3JGWkkxcjhQNVRia0RMWGpJeWo4d1J4dzV5VVhhSGNFYldq?=
 =?utf-8?B?SFp0MG1wMVdtb0lBWlRyOU1zMm9zMDNQeW9qN3RwR1VpN1BXWkpyV0Rjd0gx?=
 =?utf-8?B?L3orSzc1UUU1Z05LZlNyWmFyWThOOWlhN2tEWmRUQjZKSEZwRjczU2xMN0N2?=
 =?utf-8?B?NWxwWVpkSkZvUUtQUUppMWl2YUN1UmdmSDk3dFNycnlGc01DYlhMWGRSQzNu?=
 =?utf-8?B?OUlDeDNBK3RNZUwvbTdTby9XdWVLamc2QXVsWkN1ZTVEVkdBVDZ2Q2IvQWlo?=
 =?utf-8?B?MDlJS05YNWxjdWpERWZsdjJ4ZnhJRGR5cnFLa2RJTEJnRFZZeWZIU204cEto?=
 =?utf-8?B?Sk9JOVpvdVRVYkM0aGdlc2tFMDZGdlBSQS9TK0VBemtHR3NBcTJ2ekxIa3pV?=
 =?utf-8?B?TXBxbjArd25HQXc1SWRzZzVrdHBQNFo4bXIxTjdyelc1SitzRkhpdERsNWZj?=
 =?utf-8?B?ZmVpUHMwS050MFNkM2ljYmVhSmtIZ3Z0T3ZxR1dJZzNvSkRTalpSN0FybUll?=
 =?utf-8?B?L0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <98E7911E3BE321478E0CB5787BCF477E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UjdzcSttU0NUcmprOFQwdVV2dnlIbGo0eHpaZ0VCQWFzN2tJbXZFamx1dnZZ?=
 =?utf-8?B?QlAzbFVPQmtSTGIvS2RQQUM4VUh4RVN6NWtYc3lLbHNsQUh0aHZObnNESGxU?=
 =?utf-8?B?c0VhS2EwMkptM3JYckRJa043OGlleWo3bEg3T3MwbFBoTjNad3B4R3p5dHpr?=
 =?utf-8?B?eTNoMTB4eDNjWTVMOEU4NWk1cUpYVWFEendCdEMwNU1yLzFxdUJqTmlmZlp3?=
 =?utf-8?B?cEExV2xWQWcydW43L1RzZEhXZm9jZUtaVXJuSHdQSXpuSU10MG54VXVkc3Y3?=
 =?utf-8?B?bDFrWXRyb2xHVTM2dEw1b09UZm5VQzhINUJ5ZGVoVkRZTG5DWGF4S2FQNitt?=
 =?utf-8?B?Rm1Lei9ORFdoUmdlWVBTMElkZVpEL1pHRFdIcjR1eXR4WmV5b05MSXMxRk8y?=
 =?utf-8?B?ZElaZUEvdDBzS1pkdjlEelhod2pqblhsR0xYeHNyRG4zZE5ndVMzeUlFY21K?=
 =?utf-8?B?TlJqUWs1cHpGMVZ5M3RZMFF1amdqMWdKb1J2c1c3ZENTbUE3OXJ5dU13MHBy?=
 =?utf-8?B?NmtWa3NVeis4OXdHemZGdzN0QmdtelVLQmtYMmM4dUFoWjVpZjduaEh2TlhD?=
 =?utf-8?B?Y0hhY2svcTlaeUFGREwrU3ZuOEJJcWpKaXRBb24wWU94bWdFa3FSTWZJblA2?=
 =?utf-8?B?R3dRZ2lzR28rQ2NIUGxJdE5XMkVzWjZpK0N0MDRvbFZzeVVFZWE1dXpVUXBp?=
 =?utf-8?B?U3RpcFlOdzBMazF1bGpWeGNyU2xrcEhQdFQycWUzZkZQVWJhanRFcnhWTkxa?=
 =?utf-8?B?RkJOTzhINS8vYytXTzljemNiZlUxMnZQVXVkZm5kNWswaVZkbHFFakpTTTNy?=
 =?utf-8?B?d1g1NWN1ckR0QnlOSG9RbHorSHV3Z0RRVHdpblF2enJnWGtBYkVhUU80ZnBB?=
 =?utf-8?B?YWh3ejUvckRzL1JKMDRkTU04cFp1dy9uRitXaDkzaGhQWVpOUDFxem1ZNTNI?=
 =?utf-8?B?NGJKK20rdEdCeHE1U2tScFhpS3duK2VQZ2k5RE0vbWczbk83UE1TaHpnN0Qr?=
 =?utf-8?B?M3RmZ3ZwWUJlQk9WeDhWenFYbEQvWTY4eGRpVDBPMHhRRmFQSUY1UFB1MlIr?=
 =?utf-8?B?RlY1aEVmUTZMY0NDcFFheVQvUzVibk9pR1hyNU5ab0huZFRLd3J0MW95dG9p?=
 =?utf-8?B?YkpoUE16UnZUOHBwSW1JcWhxVU8xOW5VTmtqS0E0UXdya1ZDMkw3aTRCYjVq?=
 =?utf-8?B?K3FucHFFOXR2TTNKUWxmTjNKRCtPMHZPQjFQMUx3a252OTBFaW5WK3duNExj?=
 =?utf-8?Q?9+9o/r+lxnH2Tg6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f2f732-13ae-4f6e-3f9a-08db8ec7c00f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 17:34:37.4601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rQdtztWTUMPyDFmkGc9a/9Bbei1iqgIqnJvD6coSOAD/mjdUx4y8nxR83HTZT1c+I0XsRC8Hg0XllvoEdGmWFc+tbQ54t4q6K1wSfhnWtF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7434
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307270159
X-Proofpoint-ORIG-GUID: w9jdwSIBh2bCJIt-6w2WVq7MFYW-PQWT
X-Proofpoint-GUID: w9jdwSIBh2bCJIt-6w2WVq7MFYW-PQWT
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URI_NOVOWEL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gT24gSnVsIDI1LCAyMDIzLCBhdCA5OjQ4IEFNLCBBbmphbGkgS3Vsa2FybmkgPEFuamFs
aS5LLkt1bGthcm5pQG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4gDQo+IA0KPj4gT24gSnVsIDI1
LCAyMDIzLCBhdCA2OjA1IEFNLCBOYXJlc2ggS2FtYm9qdSA8bmFyZXNoLmthbWJvanVAbGluYXJv
Lm9yZz4gd3JvdGU6DQo+PiANCj4+IHNlbGZ0ZXN0czogY29ubmVjdG9yOiBwcm9jX2ZpbHRlciBi
dWlsZCBmYWlsZWQgd2l0aCBjbGFuZy0xNiBkdWUgdG8gYmVsb3cNCj4+IHdhcm5pbmdzIC8gZXJy
b3JzIG9uIExpbnV4IG5leHQtMjAyMzA3MjUuDQo+PiANCj4+IFJlcG9ydGVkLWJ5OiBMaW51eCBL
ZXJuZWwgRnVuY3Rpb25hbCBUZXN0aW5nIDxsa2Z0QGxpbmFyby5vcmc+DQo+PiANCj4+IGNsYW5n
IC0tdGFyZ2V0PWFhcmNoNjQtbGludXgtZ251IC1maW50ZWdyYXRlZC1hcw0KPj4gLVdlcnJvcj11
bmtub3duLXdhcm5pbmctb3B0aW9uIC1XZXJyb3I9aWdub3JlZC1vcHRpbWl6YXRpb24tYXJndW1l
bnQNCj4+IC1XZXJyb3I9b3B0aW9uLWlnbm9yZWQgLVdlcnJvcj11bnVzZWQtY29tbWFuZC1saW5l
LWFyZ3VtZW50DQo+PiAtLXRhcmdldD1hYXJjaDY0LWxpbnV4LWdudSAtZmludGVncmF0ZWQtYXMg
LVdhbGwgcHJvY19maWx0ZXIuYyAtbw0KPj4gL2hvbWUvdHV4YnVpbGQvLmNhY2hlL3R1eG1ha2Uv
YnVpbGRzLzEvYnVpbGQva3NlbGZ0ZXN0L2Nvbm5lY3Rvci9wcm9jX2ZpbHRlcg0KPj4gcHJvY19m
aWx0ZXIuYzo0MjoxMjogZXJyb3I6IGludmFsaWQgYXBwbGljYXRpb24gb2YgJ3NpemVvZicgdG8g
YW4NCj4+IGluY29tcGxldGUgdHlwZSAnc3RydWN0IHByb2NfaW5wdXQnDQo+PiBjaGFyIGJ1ZmZb
TkxfTUVTU0FHRV9TSVpFXTsNCj4+IF5+fn5+fn5+fn5+fn5+fg0KPj4gcHJvY19maWx0ZXIuYzoy
Mjo1OiBub3RlOiBleHBhbmRlZCBmcm9tIG1hY3JvICdOTF9NRVNTQUdFX1NJWkUnDQo+PiBzaXpl
b2Yoc3RydWN0IHByb2NfaW5wdXQpKQ0KPj4gXiB+fn5+fn5+fn5+fn5+fn5+fn5+DQo+PiBwcm9j
X2ZpbHRlci5jOjQyOjEyOiBub3RlOiBmb3J3YXJkIGRlY2xhcmF0aW9uIG9mICdzdHJ1Y3QgcHJv
Y19pbnB1dCcNCj4+IHByb2NfZmlsdGVyLmM6MjI6MTk6IG5vdGU6IGV4cGFuZGVkIGZyb20gbWFj
cm8gJ05MX01FU1NBR0VfU0laRScNCj4+IHNpemVvZihzdHJ1Y3QgcHJvY19pbnB1dCkpDQo+PiBe
DQo+PiBwcm9jX2ZpbHRlci5jOjQ4OjIwOiBlcnJvcjogaW52YWxpZCBhcHBsaWNhdGlvbiBvZiAn
c2l6ZW9mJyB0byBhbg0KPj4gaW5jb21wbGV0ZSB0eXBlICdzdHJ1Y3QgcHJvY19pbnB1dCcNCj4+
IGhkci0+bmxtc2dfbGVuID0gTkxfTUVTU0FHRV9TSVpFOw0KPj4gXn5+fn5+fn5+fn5+fn5+DQo+
PiBwcm9jX2ZpbHRlci5jOjIyOjU6IG5vdGU6IGV4cGFuZGVkIGZyb20gbWFjcm8gJ05MX01FU1NB
R0VfU0laRScNCj4+IHNpemVvZihzdHJ1Y3QgcHJvY19pbnB1dCkpDQo+PiBeIH5+fn5+fn5+fn5+
fn5+fn5+fn4NCj4+IHByb2NfZmlsdGVyLmM6NDI6MTI6IG5vdGU6IGZvcndhcmQgZGVjbGFyYXRp
b24gb2YgJ3N0cnVjdCBwcm9jX2lucHV0Jw0KPj4gY2hhciBidWZmW05MX01FU1NBR0VfU0laRV07
DQo+PiBeDQo+PiBwcm9jX2ZpbHRlci5jOjIyOjE5OiBub3RlOiBleHBhbmRlZCBmcm9tIG1hY3Jv
ICdOTF9NRVNTQUdFX1NJWkUnDQo+PiBzaXplb2Yoc3RydWN0IHByb2NfaW5wdXQpKQ0KPj4gXg0K
Pj4gcHJvY19maWx0ZXIuYzo2NDoxNDogZXJyb3I6IGludmFsaWQgYXBwbGljYXRpb24gb2YgJ3Np
emVvZicgdG8gYW4NCj4+IGluY29tcGxldGUgdHlwZSAnc3RydWN0IHByb2NfaW5wdXQnDQo+PiBt
c2ctPmxlbiA9IHNpemVvZihzdHJ1Y3QgcHJvY19pbnB1dCk7DQo+PiBeIH5+fn5+fn5+fn5+fn5+
fn5+fn4NCj4+IHByb2NfZmlsdGVyLmM6NDI6MTI6IG5vdGU6IGZvcndhcmQgZGVjbGFyYXRpb24g
b2YgJ3N0cnVjdCBwcm9jX2lucHV0Jw0KPj4gY2hhciBidWZmW05MX01FU1NBR0VfU0laRV07DQo+
PiBeDQo+PiBwcm9jX2ZpbHRlci5jOjIyOjE5OiBub3RlOiBleHBhbmRlZCBmcm9tIG1hY3JvICdO
TF9NRVNTQUdFX1NJWkUnDQo+PiBzaXplb2Yoc3RydWN0IHByb2NfaW5wdXQpKQ0KPj4gXg0KPj4g
cHJvY19maWx0ZXIuYzo2NTozNTogZXJyb3I6IGluY29tcGxldGUgZGVmaW5pdGlvbiBvZiB0eXBl
ICdzdHJ1Y3QgcHJvY19pbnB1dCcNCj4+ICgoc3RydWN0IHByb2NfaW5wdXQgKiltc2ctPmRhdGEp
LT5tY2FzdF9vcCA9DQo+PiB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fl4NCj4+IHBy
b2NfZmlsdGVyLmM6NDI6MTI6IG5vdGU6IGZvcndhcmQgZGVjbGFyYXRpb24gb2YgJ3N0cnVjdCBw
cm9jX2lucHV0Jw0KPj4gY2hhciBidWZmW05MX01FU1NBR0VfU0laRV07DQo+PiBeDQo+PiBwcm9j
X2ZpbHRlci5jOjIyOjE5OiBub3RlOiBleHBhbmRlZCBmcm9tIG1hY3JvICdOTF9NRVNTQUdFX1NJ
WkUnDQo+PiBzaXplb2Yoc3RydWN0IHByb2NfaW5wdXQpKQ0KPj4gXg0KPj4gcHJvY19maWx0ZXIu
Yzo2NjozMTogZXJyb3I6IGluY29tcGxldGUgZGVmaW5pdGlvbiBvZiB0eXBlICdzdHJ1Y3QgcHJv
Y19pbnB1dCcNCj4+ICgoc3RydWN0IHByb2NfaW5wdXQgKilwaW5wKS0+bWNhc3Rfb3A7DQo+PiB+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5eDQo+PiBwcm9jX2ZpbHRlci5jOjQyOjEyOiBub3Rl
OiBmb3J3YXJkIGRlY2xhcmF0aW9uIG9mICdzdHJ1Y3QgcHJvY19pbnB1dCcNCj4+IGNoYXIgYnVm
ZltOTF9NRVNTQUdFX1NJWkVdOw0KPj4gXg0KPj4gcHJvY19maWx0ZXIuYzoyMjoxOTogbm90ZTog
ZXhwYW5kZWQgZnJvbSBtYWNybyAnTkxfTUVTU0FHRV9TSVpFJw0KPj4gc2l6ZW9mKHN0cnVjdCBw
cm9jX2lucHV0KSkNCj4+IF4NCj4+IHByb2NfZmlsdGVyLmM6Njc6MzU6IGVycm9yOiBpbmNvbXBs
ZXRlIGRlZmluaXRpb24gb2YgdHlwZSAnc3RydWN0IHByb2NfaW5wdXQnDQo+PiAoKHN0cnVjdCBw
cm9jX2lucHV0ICopbXNnLT5kYXRhKS0+ZXZlbnRfdHlwZSA9DQo+PiB+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fl4NCj4+IHByb2NfZmlsdGVyLmM6NDI6MTI6IG5vdGU6IGZvcndhcmQg
ZGVjbGFyYXRpb24gb2YgJ3N0cnVjdCBwcm9jX2lucHV0Jw0KPj4gY2hhciBidWZmW05MX01FU1NB
R0VfU0laRV07DQo+PiBeDQo+PiBwcm9jX2ZpbHRlci5jOjIyOjE5OiBub3RlOiBleHBhbmRlZCBm
cm9tIG1hY3JvICdOTF9NRVNTQUdFX1NJWkUnDQo+PiBzaXplb2Yoc3RydWN0IHByb2NfaW5wdXQp
KQ0KPj4gXg0KPj4gcHJvY19maWx0ZXIuYzo2ODozMTogZXJyb3I6IGluY29tcGxldGUgZGVmaW5p
dGlvbiBvZiB0eXBlICdzdHJ1Y3QgcHJvY19pbnB1dCcNCj4+ICgoc3RydWN0IHByb2NfaW5wdXQg
KilwaW5wKS0+ZXZlbnRfdHlwZTsNCj4+IH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fl4NCj4+
IHByb2NfZmlsdGVyLmM6NDI6MTI6IG5vdGU6IGZvcndhcmQgZGVjbGFyYXRpb24gb2YgJ3N0cnVj
dCBwcm9jX2lucHV0Jw0KPj4gY2hhciBidWZmW05MX01FU1NBR0VfU0laRV07DQo+PiBeDQo+PiBw
cm9jX2ZpbHRlci5jOjIyOjE5OiBub3RlOiBleHBhbmRlZCBmcm9tIG1hY3JvICdOTF9NRVNTQUdF
X1NJWkUnDQo+PiBzaXplb2Yoc3RydWN0IHByb2NfaW5wdXQpKQ0KPj4gXg0KPj4gcHJvY19maWx0
ZXIuYzoyNDU6MjA6IGVycm9yOiB2YXJpYWJsZSBoYXMgaW5jb21wbGV0ZSB0eXBlICdzdHJ1Y3Qg
cHJvY19pbnB1dCcNCj4+IHN0cnVjdCBwcm9jX2lucHV0IGlucHV0Ow0KPj4gXg0KPj4gcHJvY19m
aWx0ZXIuYzoyNDU6OTogbm90ZTogZm9yd2FyZCBkZWNsYXJhdGlvbiBvZiAnc3RydWN0IHByb2Nf
aW5wdXQnDQo+PiBzdHJ1Y3QgcHJvY19pbnB1dCBpbnB1dDsNCj4+IF4NCj4+IHByb2NfZmlsdGVy
LmM6MjY0OjIyOiBlcnJvcjogdXNlIG9mIHVuZGVjbGFyZWQgaWRlbnRpZmllcg0KPj4gJ1BST0Nf
RVZFTlRfTk9OWkVST19FWElUJw0KPj4gaW5wdXQuZXZlbnRfdHlwZSA9IFBST0NfRVZFTlRfTk9O
WkVST19FWElUOw0KPj4gXg0KPj4gOSBlcnJvcnMgZ2VuZXJhdGVkLg0KPj4gbWFrZVs0XTogTGVh
dmluZyBkaXJlY3RvcnkgJy9idWlsZHMvbGludXgvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY29u
bmVjdG9y4oCZDQo+PiANCj4+IA0KPiBUaGVzZSBhcmUgZXhwZWN0ZWQgc2luY2UgeW91IG5lZWQg
dG8gaGF2ZSB0aGUgY2hhbmdlcyBpbiBrZXJuZWwgdGhhdCB3ZXJlIGNvbW1pdHRlZCB3aXRoIHRo
aXMgcGF0Y2ggdG8gYmUgaW5zdGFsbGVkIG9uIHRoZSBrZXJuZWwgb24gd2hpY2ggdGhpcyBpcyBi
ZWluZyBjb21waWxlZC9ydW4gb24uIFRoYXQgaXMgd2hhdCB0aGUgdGVzdCBpcyBmb3IsIGFuZCB0
aGUgY2hlY2sgdG8gbWFrZSBpdCBydW4gb24gcHJldmlvdXMga2VybmVscyBhcyB3ZWxsIHdhcyBt
YWRlIGEgcnVudGltZSBjaGVjay4gRG8geW91IGV4cGVjdCB0aGlzIHRvIGNvbXBpbGUgb24gYSBr
ZXJuZWwgd2l0aG91dCB0aGUgY29ycmVzcG9uZGluZyBrZXJuZWwgY2hhbmdlcyB0aGF0IHdlcmUg
Y29tbWl0dGVkIHdpdGggdGhpcyBwYXRjaD8NCj4gDQo+IEFuamFsaQ0KDQpHZW50bGUgcGluZyAt
ICBjb3VsZCB5b3UgYW5zd2VyIGFib3ZlIHF1ZXN0aW9ucz8NCj4gDQo+PiANCj4+IExpbmtzOg0K
Pj4gLSBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9zdG9yYWdlLnR1eHN1aXRl
LmNvbS9wdWJsaWMvbGluYXJvL2xrZnQvYnVpbGRzLzJUMzY3NkhwSzI0M2dNQkxZSkNwNE9YRG1X
bC9fXzshIUFDV1Y1TjlNMlJWOTloUSFLR3BOTE5nRjlUQjFEaTZ2bnNJQktnalFicVl5Z2hVcWVO
cjRxNHhNbDB1R2VzWU9OWjdoNUdsMjZ2VUw2Mm5WdC05WVRKbWl5RTZjd1VNN3NBakFXWUlWS1pO
S3ZNWWMkIA0KPj4gDQo+PiBzdGVwcyB0byByZXByb2R1Y2U6DQo+PiAtIGh0dHBzOi8vdXJsZGVm
ZW5zZS5jb20vdjMvX19odHRwczovL3N0b3JhZ2UudHV4c3VpdGUuY29tL3B1YmxpYy9saW5hcm8v
bGtmdC9idWlsZHMvMlQzNjc2SHBLMjQzZ01CTFlKQ3A0T1hEbVdsL3R1eG1ha2VfcmVwcm9kdWNl
ci5zaF9fOyEhQUNXVjVOOU0yUlY5OWhRIUtHcE5MTmdGOVRCMURpNnZuc0lCS2dqUWJxWXlnaFVx
ZU5yNHE0eE1sMHVHZXNZT05aN2g1R2wyNnZVTDYyblZ0LTlZVEptaXlFNmN3VU03c0FqQVdZSVZL
U2ZRS2J6SyQgDQo+PiAtLQ0KPj4gTGluYXJvIExLRlQNCj4+IGh0dHBzOi8vdXJsZGVmZW5zZS5j
b20vdjMvX19odHRwczovL2xrZnQubGluYXJvLm9yZ19fOyEhQUNXVjVOOU0yUlY5OWhRIUtHcE5M
TmdGOVRCMURpNnZuc0lCS2dqUWJxWXlnaFVxZU5yNHE0eE1sMHVHZXNZT05aN2g1R2wyNnZVTDYy
blZ0LTlZVEptaXlFNmN3VU03c0FqQVdZSVZLWWx3bExPSyQgDQoNCg==
