Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7577326A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jun 2023 07:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240784AbjFPFaR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Jun 2023 01:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240797AbjFPFaO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Jun 2023 01:30:14 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806472D69;
        Thu, 15 Jun 2023 22:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1686893408; x=1718429408;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2tUoPImWQRbY3WX5sOCcnwKVhVdV+G0wCyzLVDL65Ac=;
  b=elCHASPnTxUWm9AMSpAnrySxKdYoSgU0wFWE23PZZuxdrwIVwRg4bFvJ
   +oE2d0bkcZjbtYXDQsfDcBpS2+atyT5JVBmN7SqukW5Fe+VUSswEhEI3z
   UYf7PrOKOtlIuOamvqPr7vTSZmLZrJkH/6bXCYsaFLHUrnwZAPla5zEAV
   8Svkkm9ob4O83nvmUfj4lLP8nMvs4XI7JDtMQNpEqGXf7jAb4TPO8fygP
   Oa6HLmtUOoItlbDFXtdactT4gr54jP74wicbXvN+rA6JbSRVm94KQTDyj
   wGeC/fUjJE6do5RLMH/H4bYRADNql5SS0H3r9oOpKgtGuaioIkbYVoTla
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="87359626"
X-IronPort-AV: E=Sophos;i="6.00,246,1681138800"; 
   d="scan'208";a="87359626"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 14:30:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIIsxlpASxhBRnemM6VT5E+TVcfscpZRJBWBtv0/Ip2OAPFY2XBxECP3czZIBAPpKhvFeuE1LnkNUvU01Gkn0GCHVbYvv2mPdnlMdVSu1hK+I62tD22vldAKLLeBKhc8sc8IVj60VpkK7kZkKWoLsVY3OZVDBd0/45Wu9Tpt9K3LVebXvB/Mgq+hmNc+Wp1Bxm4JrooLGmBKW4/uBeceRUpDy37DdGqEuZTFn2NtiZc59LvjrQbG5RA7REjTcMnxRI5GDa7S/msLcDMvGTebrX62rN5SThYGML50V8/67cG4C5yWFPp1dCyHpnb+9XST5ittaiiSVTZk6g1tOC3lQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tUoPImWQRbY3WX5sOCcnwKVhVdV+G0wCyzLVDL65Ac=;
 b=ZXHy/2neie6ScUVstRKfy34uzcZ3+f0Q5Gve2cNadWGp/LIRu8lsHE/Bw8079/95999DS3LUDgzx2plgYgMU6QtUUfoZDDci2bhksEwQ4TosGJNZPU4vMS+RRy+lDvdv2Mzo6MVmTfTls7ebshXadI5bbrxqNtQG6BP1K/erIVZ3qBzOfZs5UXZikm1dCCj3//BvQEZEH+BXeWGLB20/q7khRZZKZbEEoswxX+NGFthehwoYMX9vnIGHyH/eCjv8+YDqdQHMDGQgVRFdSmVzIJjDjSp3nOE+DERQXkqCFcAXu25/JjC9/wM6GmI94GAgEJzDPtqR6BXcnE/ikF5XJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by OS3PR01MB6182.jpnprd01.prod.outlook.com (2603:1096:604:d7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 05:30:01 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::8fa6:7b20:a48:5400]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::8fa6:7b20:a48:5400%4]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 05:30:01 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     =?utf-8?B?J0lscG8gSsOkcnZpbmVuJw==?= 
        <ilpo.jarvinen@linux.intel.com>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 21/24] selftests/resctrl: Read in less obvious order to
 defeat prefetch optimizations
Thread-Topic: [PATCH v2 21/24] selftests/resctrl: Read in less obvious order
 to defeat prefetch optimizations
Thread-Index: AQHZcet39cAuWUDzBE6QdI939640H690HFtggABBOICAAUS3UIAU+uKAgAKlpwA=
Date:   Fri, 16 Jun 2023 05:30:01 +0000
Message-ID: <TYAPR01MB633074204B37B91216FA13468B58A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-22-ilpo.jarvinen@linux.intel.com>
 <OSZPR01MB6328F2713E40CC7D383035A48B489@OSZPR01MB6328.jpnprd01.prod.outlook.com>
 <c21fb16d-d3ad-bbcb-daed-28f153b64525@linux.intel.com>
 <TYAPR01MB6330025B5E6537F94DA49ACB8B499@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <b7dfc9b-74da-5fe2-9060-fd36eb636c6@linux.intel.com>
In-Reply-To: <b7dfc9b-74da-5fe2-9060-fd36eb636c6@linux.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjMtMDYtMTZUMDU6Mjg6?=
 =?utf-8?B?MDhaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD02OTQ3ZDNkYS0xMzQ5LTQ2ZTMt?=
 =?utf-8?B?YmE1MS0wZGZkNmFlNGMxNDg7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 3aae682fff434de9a194f1c83f44ece3
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|OS3PR01MB6182:EE_
x-ms-office365-filtering-correlation-id: f9478916-3821-41c4-2da2-08db6e2abb5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B4G62Bln1sPKum4Aw9XQC8CPY5cBlJFu9vPM7Wt1gOcU6L2B7er5kvj9jBoeOIIX9RzHdsUwvvBWSQNdcnQZ++7uxszTaLHigUsm2cilUMKkwkemewB37iGb9z/ab84c/O2ToZwgclcMtBvH+vZaNsFhju7Sp5QctaVQDN9vCDvucw6TV2kvLzqMfHQbCwxlrs3YFK8WKgc/S7qgSwLMAW9eKffAwi1LwPVl/m4zymWGwfmOoUtzyGDLQmvENnX/vY2LUh7b6kmhuatZlpOtCo7EIEHYNWbxNZiOcZD8vVRr3thhMJgJrkDvVi0O8G/Cvh09KbZf12h5leuNpxFJFbacKP1oR2caIWnjizpt8UMkKpocL74ROXojLCvwuA99VHaE/wTdNFGZfRu6sK/sk6/NrYIt4SKy9fFkHSOS4MaN9zpupE4v6EYvwMxmEtypArYTI8N4lEyNJ2AQuIIbjZ821uGhy3vayAxUUiTSHkHPu6b2qjCe1oAIXEWAY5TimFXi5XAqcah5a/dn9jNbz0Xlccy9iEdXqiHLbU43SSSXq9fa9Co7p7Vaxx5esjPgpScDcpAIP8qlRfy5Ez7LxbakK1gCbTl7thNdGf6HGUzx3rCWT/2FAWyZvici1NEeH/QMtfrUuwX2PXX6hpRGvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(1590799018)(451199021)(55016003)(1580799015)(54906003)(478600001)(7696005)(122000001)(5660300002)(41300700001)(8936002)(52536014)(82960400001)(38070700005)(8676002)(2906002)(86362001)(85182001)(33656002)(38100700002)(64756008)(66476007)(66556008)(66446008)(66946007)(316002)(6916009)(4326008)(76116006)(71200400001)(26005)(9686003)(6506007)(186003)(83380400001)(66574015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnAvUXo4WjNoSVBpMFcyem5aYVhjUDM5V1hyYUtmU0lDU1hWTU1maGZmVzFk?=
 =?utf-8?B?M1JhcUpyZkQ3VDlQU2hrR0lXeEgvdWIrOGtLZUdpTVFYQitaR0VYQ2lMamhD?=
 =?utf-8?B?RDRIUXl4WXlLNjFuc2pIQnJqMC9xNit0eFJUdTl3WEcwbjVjTlp2c2JXdEhE?=
 =?utf-8?B?Yy85SUZ0eTNyZmZ0L0VpK21UdVYraEpRZVRRRVpZTkVrak56WXpNZFNuY3pX?=
 =?utf-8?B?dHFaZWVmRUszczdFT0M4T0JxQUNZc29UVUZXUitFbjgzbXFBbzlDNjJlNVNR?=
 =?utf-8?B?dWgzQzcvVUUvRWZKNXVXckxNUzFJRjZHM3FxMlFMWnFzZUE0cnMxYkd4aGdD?=
 =?utf-8?B?Wkw5RENBN2lTMG9ibmMxNFArVHpqb3ZXdkwvNjc3T0xVSUNnRmFmZGdMUEw2?=
 =?utf-8?B?L2dFWk9iREJ0Tmo5UUV5VHE4amhpZnFUQTUyTTZnTW9wR2k4VzM5aGRTTDBV?=
 =?utf-8?B?Vm0xc0NhOHhZYkRYMjVYU0FKUkJydjBWdlBiT2xxdFF5YTVxUDRBcTEwRjdk?=
 =?utf-8?B?Rkp5alVmMU9qSTlJQjA2U1hnZm4zZEFuYndJM1B6R0pSb1BNM3N5dzBPbjdn?=
 =?utf-8?B?Y21mTHYrdmZzM1JxTE9KVjh1QmhCejdFOVVTR2E1QmdsQXhuK2NHRStnSmw0?=
 =?utf-8?B?emY0WTIrTkR0NUttSXl0SklVRWdJdVlicXc4clpXZkRISXJXa1FWWVBQdmtR?=
 =?utf-8?B?N1BxSldTbVhkb21GWG5iRjBuTDZzVzVIUUFSRGYzY2VxK2JFTmFRRmt2Lzcv?=
 =?utf-8?B?b3dQSHRQVm54THR4TnptTkJTWFRNTjZTaWVoWmR0TjgybWYyL2hpNSsrNDht?=
 =?utf-8?B?dSsrUWVKUHl3RHc2R3BMTTBsYllobmlIeFMxMERsdDdiWUVJYlBQdVVRU2N2?=
 =?utf-8?B?VkczakExNk9rVjR4a1NudWQ3MTZKVHZDVEZOZnEyNGU2YmFDcnlBUlZ3VWdJ?=
 =?utf-8?B?Z3I4TTYyL0tyS1dVTWVBbWM5VEhsN09YOGVNNHBXcDhYUzZCR29DMXF2anp5?=
 =?utf-8?B?ZkZqYmFkQytqRU1DNEg3R3FUT0ZGclRwbzZpNkN0NWtsU0p3aC80QzNobitK?=
 =?utf-8?B?TWlYb3dBZ3ljQmdGeDZHdVdqYzdqM25GcWttNVQvNnJxL2JMcmxHR3RPY21q?=
 =?utf-8?B?UVBDeUJwTVlXTG5LVFFSeCtCL24zdzA0N3pUdGVJOFU0QWdnTFQ3SDFjVTRh?=
 =?utf-8?B?SWtGUHhQTGVCa01kazNud0lEVElLc3YzQlBxM211L0dKUkdZbThqZEg2YVF2?=
 =?utf-8?B?a3NGMkQxbzFGdHJ6dmZ2d3Q2aUNMTDl2TGwwNlJBbUlJM1hkWmZtRGdKcGVq?=
 =?utf-8?B?Qkx1WFJsc2ZscFZ4RXlYMnNFNjJLQ0JSM3FlTThrU1I1YXlTV3NnK21ESWc2?=
 =?utf-8?B?cVBhcDE2a3VmUmliY0NreGhDRjllTlA5UitGdkNuMFJBclFKUHBoS3ovM202?=
 =?utf-8?B?dnZ3UEpZZGJGZEM3Qk9PbUNsc3R1NmVvOTZtUWxjMXhxekhqb3Bod3ZvZC8y?=
 =?utf-8?B?U0o5UXBGdUJPVk53RTlHT0R1YlpCSDBwRkV3Q3B5Q3hNRWh0cFNzbklzb2Fz?=
 =?utf-8?B?NTYyUWJicGxFMDdXYVErOFl2RlN5Zk1wRTg3TWdWV3VaeGgvTnpmUldRSzFx?=
 =?utf-8?B?QStISk5acFYyUWVLdFJpTTBuS3hIZGFCZWxlQWwvTHlBQkE0M0Y5WVFqSUVw?=
 =?utf-8?B?MXphUEtEanNHaGJWa2M1THE2RHZMY0l4R1FEbVdScTFQb29tbUFzSGJncXVU?=
 =?utf-8?B?NHltQzZSU21tVVU1WGhvaUxDd3dKSlpSOWxhTmRVdVlJbVQxa1V2eFNwNjRn?=
 =?utf-8?B?K0UzOUJ4bHR4elhjMEEwS3hsWFRJY0V5ZVM5bDNKdkp3ZGJkQkwvZ3FlU01p?=
 =?utf-8?B?dlpZY29BdHlrek9oRVhScVFKL0E1QWYwKzNWR2xTdDZveWtSUktFL1VhbFEx?=
 =?utf-8?B?TEtrb2lzMHZwRWJGdC9GWWx2aUJoWk1VVkxSRlRCMVhXVVE0cXNkL1JXUGdW?=
 =?utf-8?B?OFFpVXNxRUdBeXpiTzI3S0VWR3BYKzdKaXN6emp5blp3ZXRadFh6aklmYmNw?=
 =?utf-8?B?Z3ZXQ0VnUTlKeGhpVzNpVW9leVNWajRHMEFOWmZmU3dTODFtK2dFK1VTTUx0?=
 =?utf-8?B?c1htbkROTFVRUDNUUkluRkpPcFZUZmxtdGJ4UWdxNVFCbGQybWtHaHdaTU42?=
 =?utf-8?B?ZEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ExRieGSpUATiivcyv4bTQkKZ4dXpyJ6MI+iGb8ZDKZA1DnpBQYqzU/F9G/AiEY96WAbEtz1/0oel85LoNFk1kq6vGPfKQmKQKIkJQiDPwPdM92Bp9btAkzQX5R+Sd5/t3YRnExqc8ltPYhXPlNVIrjkPD2QSIXhBDJNhQCV8ohRw9fXceVI9K01YWFYAa8Gbb/sPMJ8dzHfP7+w/1j/yvXbv3JW3OzwGltpSEspl+wa2Is06vjLoVPcfbFT76vevb8pkcNCFQ3hmgjXrEdHjgN5JkhMqo9Otr/qPPAy82tXwnCT7vycRYMPsTyKQwySSsTvpqg5Kx/JrOfM9hM9HhDIgoLkN9vAyNr7C5+mVguuNNEgiGdt9rS01tQ4EwxssghFCH2BMbkRscWWfxhXi+XZ33ZUctkdGWddXBlSqR4sAxw+/BtT4UsCu+G9CL1acwdYRIoo9cxvy3QpVqzqVdbx7kYN+2kaGOch0fK0GwNPCL5sS3MRiquVYhp3dokbEBr2NG0vaG/QPAJW+Mx/VuzrQOcJNDX8O6hG3PMcDbFXYSYw58BWDK9+zVxL+cE9DRNiwFw8Gl0NkB9vmYV7zilW9p9Z3yIzwEc3UKfhVIDlUlrOrkmd1y5qkTLeOHdqnQk5qIw2BkeT0+20UdYk9+7uew9UxsXG21aK+3C1mLS8I8D/FPEi6XbxNf2rMRjiEo3na3urx9UbwL0q2E4FgsvJeLwsqKOBlGcp/VmbuJBxoDyGeajFUUkf9AYv4uv2oy8tboRArZzTXLGBrKoNbGdgx8APIFSMZT2awyw2Q4e5Fcj5tmCPnrnQMZHTd/XgPVJCkDBP0mx2+lcGituP9uFrHqTtcQ8dtecFSl1xsu46P9jq/y/T0PEw5MD2YYSIr
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9478916-3821-41c4-2da2-08db6e2abb5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 05:30:01.3922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kqgoKdEz3blh9P1e7CTEJlU7TtMOMKwuoXrwRN1/ym+uR4Mk/27Q3ARdEENVi2XXBX8xx/EOMtx36yt2AulwAEHAthbXrNe5DvSpgkQCDtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6182
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgSWxwbywNCg0KPiBPbiBUaHUsIDEgSnVuIDIwMjMsIFNoYW9wZW5nIFRhbiAoRnVqaXRzdSkg
d3JvdGU6DQo+ID4gPiA+ID4gV2hlbiByZWFkaW5nIG1lbW9yeSBpbiBvcmRlciwgSFcgcHJlZmV0
Y2hpbmcgb3B0aW1pemF0aW9ucyB3aWxsDQo+ID4gPiA+ID4gaW50ZXJmZXJlIHdpdGggbWVhc3Vy
aW5nIGhvdyBjYWNoZXMgYW5kIG1lbW9yeSBhcmUgYmVpbmcgYWNjZXNzZWQuDQo+ID4gPiA+ID4g
VGhpcyBhZGRzIG5vaXNlIGludG8gdGhlIHJlc3VsdHMuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBD
aGFuZ2UgdGhlIGZpbGxfYnVmIHJlYWRpbmcgbG9vcCB0byBub3QgdXNlIGFuIG9idmlvdXMgaW4t
b3JkZXINCj4gPiA+ID4gPiBhY2Nlc3MgdXNpbmcgbXVsdGlwbHkgYnkgYSBwcmltZSBhbmQgbW9k
dWxvLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSWxwbyBKw6RydmluZW4g
PGlscG8uamFydmluZW5AbGludXguaW50ZWwuY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+
ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL2ZpbGxfYnVmLmMgfCAxNw0KPiA+ID4g
PiA+ICsrKysrKysrKystLS0tLS0tDQo+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNl
cnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gZGlmZiAtLWdp
dCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvZmlsbF9idWYuYw0KPiA+ID4gPiA+
IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9maWxsX2J1Zi5jDQo+ID4gPiA+ID4g
aW5kZXggN2UwZDNhMWVhNTU1Li4wNDlhNTIwNDk4YTkgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9maWxsX2J1Zi5jDQo+ID4gPiA+ID4gKysr
IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9maWxsX2J1Zi5jDQo+ID4gPiA+ID4g
QEAgLTg4LDE0ICs4OCwxNyBAQCBzdGF0aWMgdm9pZCAqbWFsbG9jX2FuZF9pbml0X21lbW9yeShz
aXplX3QNCj4gPiA+ID4gPiBzKQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gIHN0YXRpYyBpbnQgZmls
bF9vbmVfc3Bhbl9yZWFkKHVuc2lnbmVkIGNoYXIgKnN0YXJ0X3B0ciwNCj4gPiA+ID4gPiB1bnNp
Z25lZCBjaGFyDQo+ID4gPiA+ID4gKmVuZF9wdHIpICB7DQo+ID4gPiA+ID4gLQl1bnNpZ25lZCBj
aGFyIHN1bSwgKnA7DQo+ID4gPiA+ID4gLQ0KPiA+ID4gPiA+ICsJdW5zaWduZWQgaW50IHNpemUg
PSAoZW5kX3B0ciAtIHN0YXJ0X3B0cikgLyAoQ0xfU0laRSAvIDIpOw0KPiA+ID4gPiA+ICsJdW5z
aWduZWQgaW50IGNvdW50ID0gc2l6ZTsNCj4gPiA+ID4gPiArCXVuc2lnbmVkIGNoYXIgc3VtOw0K
PiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArCS8qDQo+ID4gPiA+ID4gKwkgKiBSZWFkIHRoZSBidWZm
ZXIgaW4gYW4gb3JkZXIgdGhhdCBpcyB1bmV4cGVjdGVkIGJ5IEhXDQo+IHByZWZldGNoaW5nDQo+
ID4gPiA+ID4gKwkgKiBvcHRpbWl6YXRpb25zIHRvIHByZXZlbnQgdGhlbSBpbnRlcmZlcmluZyB3
aXRoIHRoZSBjYWNoaW5nDQo+IHBhdHRlcm4uDQo+ID4gPiA+ID4gKwkgKi8NCj4gPiA+ID4gPiAg
CXN1bSA9IDA7DQo+ID4gPiA+ID4gLQlwID0gc3RhcnRfcHRyOw0KPiA+ID4gPiA+IC0Jd2hpbGUg
KHAgPCBlbmRfcHRyKSB7DQo+ID4gPiA+ID4gLQkJc3VtICs9ICpwOw0KPiA+ID4gPiA+IC0JCXAg
Kz0gKENMX1NJWkUgLyAyKTsNCj4gPiA+ID4gPiAtCX0NCj4gPiA+ID4gPiArCXdoaWxlIChjb3Vu
dC0tKQ0KPiA+ID4gPiA+ICsJCXN1bSArPSBzdGFydF9wdHJbKChjb3VudCAqIDU5KSAlIHNpemUp
ICogQ0xfU0laRSAvIDJdOw0KPiA+ID4gPg0KPiA+ID4gPiBDb3VsZCB5b3UgcGxlYXNlIGVsYWJv
cmF0ZSB3aHkgNTkgaXMgdXNlZD8NCj4gPiA+DQo+ID4gPiBUaGUgbWFpbiByZWFzb24gaXMgdGhh
dCBpdCdzIGEgcHJpbWUgbnVtYmVyIGVuc3VyaW5nIHRoZSB3aG9sZSBidWZmZXIgZ2V0cw0KPiBy
ZWFkLg0KPiA+ID4gSSBwaWNrZWQgc29tZXRoaW5nIHRoYXQgZG9lc24ndCBtYWtlIGl0IHRvIHdy
YXAgb24gYWxtb3N0IGV2ZXJ5IGl0ZXJhdGlvbi4NCj4gPg0KPiA+IFRoYW5rcyBmb3IgeW91ciBl
eHBsYW5hdGlvbi4gSXQgc2VlbXMgdGhlcmUgaXMgbm8gcHJvYmxlbS4NCj4gPg0KPiA+IFBlcmhh
cHMgeW91IGhhdmUgYWxyZWFkeSB0ZXN0ZWQgdGhpcyBwYXRjaCBpbiB5b3VyIGVudmlyb25tZW50
IGFuZCBnb3QgYSB0ZXN0DQo+IHJlc3VsdCBvZiAib2siLg0KPiA+IEJlY2F1c2UgSFcgcHJlZmV0
Y2hpbmcgZG9lcyBub3Qgd29yayB3ZWxsLCB0aGUgSU1DIGNvdW50ZXIgZmx1Y3R1YXRlcw0KPiA+
IGEgbG90IGluIG15IGVudmlyb25tZW50LCBhbmQgdGhlIHRlc3QgcmVzdWx0IGlzICJub3Qgb2si
Lg0KPiA+DQo+ID4gSW4gb3JkZXIgdG8gZW5zdXJlIHRoaXMgdGVzdCBzZXQgcnVucyBpbiBhbnkg
ZW52aXJvbm1lbnRzIGFuZCBnZXRzDQo+ID4gIm9rIiwgd291bGQgeW91IGNvbnNpZGVyIGNoYW5n
aW5nIHRoZSB2YWx1ZSBvZiBNQVhfRElGRl9QRVJDRU5UIG9mDQo+IGVhY2ggdGVzdD8NCj4gPiBv
ciBjaGFuZ2luZyBzb21ldGhpbmcgZWxzZT8NCj4gPg0KPiA+IGBgYA0KPiA+IEVudmlyb25tZW50
Og0KPiA+ICBLZXJuZWw6IDYuNC4wLXJjMg0KPiA+ICBDUFU6IEludGVsKFIpIFhlb24oUikgR29s
ZCA2MjU0IENQVSBAIDMuMTBHSHoNCj4gPg0KPiA+IFRlc3QgcmVzdWx0KE1CTSBhcyBhbiBleGFt
cGxlKToNCj4gPiAjICMgU3RhcnRpbmcgTUJNIEJXIGNoYW5nZSAuLi4NCj4gPiAjICMgTW91bnRp
bmcgcmVzY3RybCB0byAiL3N5cy9mcy9yZXNjdHJsIg0KPiA+ICMgIyBCZW5jaG1hcmsgUElEOiA4
NjcxDQo+ID4gIyAjIFdyaXRpbmcgYmVuY2htYXJrIHBhcmFtZXRlcnMgdG8gcmVzY3RybCBGUyAj
ICMgV3JpdGUgc2NoZW1hDQo+ID4gIk1COjA9MTAwIiB0byByZXNjdHJsIEZTICMgIyBDaGVja2lu
ZyBmb3IgcGFzcy9mYWlsICMgIyBGYWlsOiBDaGVjaw0KPiA+IE1CTSBkaWZmIHdpdGhpbiA1JSAj
ICMgYXZnX2RpZmZfcGVyOiA5JSAjICMgU3BhbiBpbiBieXRlczogMjYyMTQ0MDAwICMNCj4gPiAj
IGF2Z19id19pbWM6IDYyMDIgIyAjIGF2Z19id19yZXNjOiA1NTg1ICMgbm90IG9rIDEgTUJNOiBi
dyBjaGFuZ2UgYGBgDQo+IA0KPiBDb3VsZCB5b3UgdHJ5IGlmIHRoZSBhcHByb2FjaCBiZWxvdyB3
b3JrcyBiZXR0ZXIgKEkgdGhpbmsgaXQgc2hvdWxkIGFwcGx5IGNsZWFubHkNCj4gb24gdG9wIG9m
IHRoZSBmaXhlcytjbGVhbnVwcyB2MyBzZXJpZXMgd2hpY2ggeW91IHJlY2VudGx5IHRlc3RlZCwg
bm8gbmVlZCB0bw0KPiBoYXZlIHRoZSBvdGhlciBDQVQgdGVzdCBjaGFuZ2VzKS4NCg0KSSByYW4g
dGhlIHRlc3Qgc2V0IHNldmVyYWwgdGltZXMuIA0KTUJBIGFuZCBNQk0gc2VlbSBmaW5lLCBidXQg
Q0FUIGlzIGFsd2F5cyAibm90IG9rIi4NClRoZSByZXN1bHQgaXMgYmVsb3cuDQoNCi0tLQ0KJCBz
dWRvIG1ha2UgLUMgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybCBydW5fdGVzdHMNCm1h
a2U6IEVudGVyaW5nIGRpcmVjdG9yeSAnLyoqL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0
cmwnDQpUQVAgdmVyc2lvbiAxMw0KMS4uMQ0KIyBzZWxmdGVzdHM6IHJlc2N0cmw6IHJlc2N0cmxf
dGVzdHMNCiMgVEFQIHZlcnNpb24gMTMNCiMgIyBQYXNzOiBDaGVjayBrZXJuZWwgc3VwcG9ydHMg
cmVzY3RybCBmaWxlc3lzdGVtDQojICMgUGFzczogQ2hlY2sgcmVzY3RybCBtb3VudHBvaW50ICIv
c3lzL2ZzL3Jlc2N0cmwiIGV4aXN0cw0KIyAjIHJlc2N0cmwgZmlsZXN5c3RlbSBub3QgbW91bnRl
ZA0KIyAjIGRtZXNnOiBbICAgIDMuNjU4MDI5XSByZXNjdHJsOiBMMyBhbGxvY2F0aW9uIGRldGVj
dGVkDQojICMgZG1lc2c6IFsgICAgMy42NTg0MjBdIHJlc2N0cmw6IE1CIGFsbG9jYXRpb24gZGV0
ZWN0ZWQNCiMgIyBkbWVzZzogWyAgICAzLjY1ODYwNF0gcmVzY3RybDogTDMgbW9uaXRvcmluZyBk
ZXRlY3RlZA0KIyAxLi40DQojICMgU3RhcnRpbmcgTUJNIEJXIGNoYW5nZSAuLi4NCiMgIyBNb3Vu
dGluZyByZXNjdHJsIHRvICIvc3lzL2ZzL3Jlc2N0cmwiDQojICMgQmVuY2htYXJrIFBJRDogOTU1
NQ0KIyAjIFdyaXRpbmcgYmVuY2htYXJrIHBhcmFtZXRlcnMgdG8gcmVzY3RybCBGUw0KIyAjIFdy
aXRlIHNjaGVtYSAiTUI6MD0xMDAiIHRvIHJlc2N0cmwgRlMNCiMgIyBDaGVja2luZyBmb3IgcGFz
cy9mYWlsDQojICMgUGFzczogQ2hlY2sgTUJNIGRpZmYgd2l0aGluIDUlDQojICMgYXZnX2RpZmZf
cGVyOiAwJQ0KIyAjIFNwYW4gKE1CKTogMjUwDQojICMgYXZnX2J3X2ltYzogNjg4MA0KIyAjIGF2
Z19id19yZXNjOiA2ODk1DQojIG9rIDEgTUJNOiBidyBjaGFuZ2UNCiMgIyBTdGFydGluZyBNQkEg
U2NoZW1hdGEgY2hhbmdlIC4uLg0KIyAjIE1vdW50aW5nIHJlc2N0cmwgdG8gIi9zeXMvZnMvcmVz
Y3RybCINCiMgIyBCZW5jaG1hcmsgUElEOiA5NTYxDQojICMgV3JpdGluZyBiZW5jaG1hcmsgcGFy
YW1ldGVycyB0byByZXNjdHJsIEZTDQojICMgV3JpdGUgc2NoZW1hICJNQjowPTEwMCIgdG8gcmVz
Y3RybCBGUw0KIyAjIFdyaXRlIHNjaGVtYSAiTUI6MD05MCIgdG8gcmVzY3RybCBGUw0KIyAjIFdy
aXRlIHNjaGVtYSAiTUI6MD04MCIgdG8gcmVzY3RybCBGUw0KIyAjIFdyaXRlIHNjaGVtYSAiTUI6
MD03MCIgdG8gcmVzY3RybCBGUw0KIyAjIFdyaXRlIHNjaGVtYSAiTUI6MD02MCIgdG8gcmVzY3Ry
bCBGUw0KIyAjIFdyaXRlIHNjaGVtYSAiTUI6MD01MCIgdG8gcmVzY3RybCBGUw0KIyAjIFdyaXRl
IHNjaGVtYSAiTUI6MD00MCIgdG8gcmVzY3RybCBGUw0KIyAjIFdyaXRlIHNjaGVtYSAiTUI6MD0z
MCIgdG8gcmVzY3RybCBGUw0KIyAjIFdyaXRlIHNjaGVtYSAiTUI6MD0yMCIgdG8gcmVzY3RybCBG
Uw0KIyAjIFdyaXRlIHNjaGVtYSAiTUI6MD0xMCIgdG8gcmVzY3RybCBGUw0KIyAjIFJlc3VsdHMg
YXJlIGRpc3BsYXllZCBpbiAoTUIpDQojICMgUGFzczogQ2hlY2sgTUJBIGRpZmYgd2l0aGluIDUl
IGZvciBzY2hlbWF0YSAxMDANCiMgIyBhdmdfZGlmZl9wZXI6IDAlDQojICMgYXZnX2J3X2ltYzog
Njg3NA0KIyAjIGF2Z19id19yZXNjOiA2OTA0DQojICMgUGFzczogQ2hlY2sgTUJBIGRpZmYgd2l0
aGluIDUlIGZvciBzY2hlbWF0YSA5MA0KIyAjIGF2Z19kaWZmX3BlcjogMSUNCiMgIyBhdmdfYndf
aW1jOiA2NzM4DQojICMgYXZnX2J3X3Jlc2M6IDY4MDcNCiMgIyBQYXNzOiBDaGVjayBNQkEgZGlm
ZiB3aXRoaW4gNSUgZm9yIHNjaGVtYXRhIDgwDQojICMgYXZnX2RpZmZfcGVyOiAxJQ0KIyAjIGF2
Z19id19pbWM6IDY3MzUNCiMgIyBhdmdfYndfcmVzYzogNjgwMw0KIyAjIFBhc3M6IENoZWNrIE1C
QSBkaWZmIHdpdGhpbiA1JSBmb3Igc2NoZW1hdGEgNzANCiMgIyBhdmdfZGlmZl9wZXI6IDElDQoj
ICMgYXZnX2J3X2ltYzogNjcwMg0KIyAjIGF2Z19id19yZXNjOiA2NzcwDQojICMgUGFzczogQ2hl
Y2sgTUJBIGRpZmYgd2l0aGluIDUlIGZvciBzY2hlbWF0YSA2MA0KIyAjIGF2Z19kaWZmX3Blcjog
MSUNCiMgIyBhdmdfYndfaW1jOiA2NjMyDQojICMgYXZnX2J3X3Jlc2M6IDY3MjUNCiMgIyBQYXNz
OiBDaGVjayBNQkEgZGlmZiB3aXRoaW4gNSUgZm9yIHNjaGVtYXRhIDUwDQojICMgYXZnX2RpZmZf
cGVyOiAxJQ0KIyAjIGF2Z19id19pbWM6IDY1MTANCiMgIyBhdmdfYndfcmVzYzogNjYzNQ0KIyAj
IFBhc3M6IENoZWNrIE1CQSBkaWZmIHdpdGhpbiA1JSBmb3Igc2NoZW1hdGEgNDANCiMgIyBhdmdf
ZGlmZl9wZXI6IDIlDQojICMgYXZnX2J3X2ltYzogNjIwNg0KIyAjIGF2Z19id19yZXNjOiA2MzQy
DQojICMgUGFzczogQ2hlY2sgTUJBIGRpZmYgd2l0aGluIDUlIGZvciBzY2hlbWF0YSAzMA0KIyAj
IGF2Z19kaWZmX3BlcjogMSUNCiMgIyBhdmdfYndfaW1jOiAzODI2DQojICMgYXZnX2J3X3Jlc2M6
IDM4OTYNCiMgIyBQYXNzOiBDaGVjayBNQkEgZGlmZiB3aXRoaW4gNSUgZm9yIHNjaGVtYXRhIDIw
DQojICMgYXZnX2RpZmZfcGVyOiAxJQ0KIyAjIGF2Z19id19pbWM6IDI4MjANCiMgIyBhdmdfYndf
cmVzYzogMjg2Mg0KIyAjIFBhc3M6IENoZWNrIE1CQSBkaWZmIHdpdGhpbiA1JSBmb3Igc2NoZW1h
dGEgMTANCiMgIyBhdmdfZGlmZl9wZXI6IDElDQojICMgYXZnX2J3X2ltYzogMTg3Ng0KIyAjIGF2
Z19id19yZXNjOiAxODk4DQojICMgUGFzczogQ2hlY2sgc2NoZW1hdGEgY2hhbmdlIHVzaW5nIE1C
QQ0KIyBvayAyIE1CQTogc2NoZW1hdGEgY2hhbmdlDQojICMgU3RhcnRpbmcgQ01UIHRlc3QgLi4u
DQojICMgTW91bnRpbmcgcmVzY3RybCB0byAiL3N5cy9mcy9yZXNjdHJsIg0KIyAjIENhY2hlIHNp
emUgOjI1OTUyMjU2DQojICMgQmVuY2htYXJrIFBJRDogOTU3Mw0KIyAjIFdyaXRpbmcgYmVuY2ht
YXJrIHBhcmFtZXRlcnMgdG8gcmVzY3RybCBGUw0KIyAjIENoZWNraW5nIGZvciBwYXNzL2ZhaWwN
CiMgIyBQYXNzOiBDaGVjayBjYWNoZSBtaXNzIHJhdGUgd2l0aGluIDE1JQ0KIyAjIFBlcmNlbnQg
ZGlmZj0xMA0KIyAjIE51bWJlciBvZiBiaXRzOiA1DQojICMgQXZlcmFnZSBMTEMgdmFsOiAxMjk5
NDU2MA0KIyAjIENhY2hlIHNwYW4gKGJ5dGVzKTogMTE3OTY0ODANCiMgb2sgMyBDTVQ6IHRlc3QN
CiMgIyBTdGFydGluZyBDQVQgdGVzdCAuLi4NCiMgIyBNb3VudGluZyByZXNjdHJsIHRvICIvc3lz
L2ZzL3Jlc2N0cmwiDQojICMgQ2FjaGUgc2l6ZSA6MjU5NTIyNTYNCiMgIyBXcml0aW5nIGJlbmNo
bWFyayBwYXJhbWV0ZXJzIHRvIHJlc2N0cmwgRlMNCiMgIyBXcml0ZSBzY2hlbWEgIkwzOjA9M2Yi
IHRvIHJlc2N0cmwgRlMNCiMgIyBDaGVja2luZyBmb3IgcGFzcy9mYWlsDQojICMgRmFpbDogQ2hl
Y2sgY2FjaGUgbWlzcyByYXRlIHdpdGhpbiA0JQ0KIyAjIFBlcmNlbnQgZGlmZj0yNA0KIyAjIE51
bWJlciBvZiBiaXRzOiA2DQojICMgQXZlcmFnZSBMTEMgdmFsOiAyNzU0MTgNCiMgIyBDYWNoZSBz
cGFuIChsaW5lcyk6IDIyMTE4NA0KIyBub3Qgb2sgNCBDQVQ6IHRlc3QNCiMgIyBUb3RhbHM6IHBh
c3M6MyBmYWlsOjEgeGZhaWw6MCB4cGFzczowIHNraXA6MCBlcnJvcjowDQpub3Qgb2sgMSBzZWxm
dGVzdHM6IHJlc2N0cmw6IHJlc2N0cmxfdGVzdHMgIyBleGl0PTENCm1ha2U6IExlYXZpbmcgZGly
ZWN0b3J5ICcvKiovdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybCcNCi0tLQ0KDQpCZXN0
IHJlZ2FyZHMsDQpTaGFvcGVuZyBUQU4NCg==
