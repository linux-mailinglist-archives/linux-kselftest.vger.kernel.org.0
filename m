Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B31599FB0
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 18:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351938AbiHSQS0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 12:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352632AbiHSQRY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 12:17:24 -0400
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D68A11777D;
        Fri, 19 Aug 2022 09:00:26 -0700 (PDT)
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JEMTrC024755;
        Fri, 19 Aug 2022 15:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=qh7CPvJBcrNqbmHOTHMOpj5KEnxIhrLjQVFryYQxGIQ=;
 b=iV2Xbxqg32IteSvgzytL+hEOTqt3OWYo9D5L7Sd6U5HSaxDe3P9W2Pk4MTjVDkyHTZLu
 glaoRqVxn0KbPgtz3b3MvvBqMSP6JGU41W92NLoG3wqbIVJTSNa63QdJRVMJH8wph/kx
 einqFs40vzaJUwzyqOEGbKuwnTCpDayj6sPoEZZygvupKNhKT6oZmfrx/s3EsVREESTR
 8JjNcSNLt75M7aAxKZmUQHPgtUbOawf5mV0GZCs55H7H6Ib9GMWuddzN+PsqLgfAi8Fx
 VQ03wrXGhZCh5D4HWQhryZPUB45rqL8N9KvYLBooVJOgk4gf7hbOzL5ZaSeLM0vRcJDH NA== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3j0nh3b4vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 15:59:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ly+BWPEOqgHIufevbk0DagQnhozwkfgVkuxZ+3+5zMpKMHrGmsWzr8VdpM0kEb7fm5Iwjv6TWgudfHtFGbOmC2jex2M4vfAzSflkBwvxpdwXmlreL5tppsWPyucTViBP0Iz5PpmVGyBIE3EwrNT5G7iU4SutLSLDNbL7C6XIFgUBtmOxe9SeoKRHYfAwDWHfbwkPiZq+VNeUk7PahXjqvRGIMot7s3EL59qwEN5dZ+aLF8IIU903vpuGRGPx34Xsg65Vyt+e4eDuuM6LLkQH+vHK72XH0LNgzcaFWSHy4ObT69JD9U1bV5mwoWbhPEa0amfhRM357RGPK5s/rYkUjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qh7CPvJBcrNqbmHOTHMOpj5KEnxIhrLjQVFryYQxGIQ=;
 b=oAJWZQ7nTQUNjLgV9StrT23WcVQ3/62ds/s4nnBc26ZAE4hCY1k5iqaTy3MgcbhmMUWnp0ZkxI0JEYkbB5aR2K9wZHe2N9EwW5fZ1NpdSFY9fm7zqRbXl850UMWf2dAj1jny2ejgX0Gj+QMulZy394ZjBs3wOhS/NQux+XwpWCSlh5AxtTJpRrKJ+0jE0nBeMwOnMYxkxNWFp4KD/14hKeYLwmd+Bcw5Y/xDjC+OH7QqVYAXFFTi0T0zBQRKvScbahl7dF4bCYWN2fBT+q9fqX4COai7GP/nz2ujRPk820IGF3R70pGiGL4jjiEdnS8cQZKd9AQ4Mk4hrazuA0cTuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by CH2PR13MB3446.namprd13.prod.outlook.com (2603:10b6:610:2b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.15; Fri, 19 Aug
 2022 15:59:38 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::999:56bf:f8d3:7f30]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::999:56bf:f8d3:7f30%7]) with mapi id 15.20.5546.015; Fri, 19 Aug 2022
 15:59:38 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Tales Aparecida <tales.aparecida@gmail.com>,
        Sadiya Kazi <sadiyakazi@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "davidgow@google.com" <davidgow@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "brendan.higgins@linux.dev" <brendan.higgins@linux.dev>,
        Trevor Woerner <twoerner@gmail.com>,
        "siqueirajordao@riseup.net" <siqueirajordao@riseup.net>,
        "mwen@igalia.com" <mwen@igalia.com>,
        "andrealmeid@riseup.net" <andrealmeid@riseup.net>,
        "mairacanal@riseup.net" <mairacanal@riseup.net>,
        Isabella Basso <isabbasso@riseup.net>,
        "magalilemes00@gmail.com" <magalilemes00@gmail.com>
Subject: RE: [PATCH 5/8] Documentation: KUnit: add intro to the
 getting-started page
Thread-Topic: [PATCH 5/8] Documentation: KUnit: add intro to the
 getting-started page
Thread-Index: AQHYs402hlnHQWHkq0G9oRRbpGHVP622Yb0w
Date:   Fri, 19 Aug 2022 15:59:38 +0000
Message-ID: <BYAPR13MB25031D6AEDAE9CBCBC5EDD69FD6C9@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <20220819053234.241501-1-tales.aparecida@gmail.com>
 <20220819053234.241501-6-tales.aparecida@gmail.com>
In-Reply-To: <20220819053234.241501-6-tales.aparecida@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a557e534-237a-46a0-0e85-08da81fbd213
x-ms-traffictypediagnostic: CH2PR13MB3446:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1mu+dppK/PtIaMd40Gim3aGc6ZFE2If1XOSFkDd4nUvtM1XO2Iq+DcVUxDkH1l2JNYAESS5hd5p/dWsrdi6EcTdStGgRKRzx48vxPwbc2DK6VuOFrcOnv0qbePYIwTCYtnBS+31Zbbbati3Z7g7+9h8zPXeCAV0GT4Uj6wXXKGv/Ia+FaCF9fOzi4H/b4/G0blszCyWQqmCU+8yaOSTbEICsbh/S6vpCD6yJvDEuPM8BJxwy6CNF1jIEfLYtkcJnOOXUomX/vFxU9oioKSw8gkNWKhLsX3TRbztN86LxDXUjVWcsR2XcYz0ZKRLzEBHv4BnfR7Qh935Zat+/EweCb/6UobRtEAb0a74HqJBuecIxdZmlxgFl0So4UbfL5PPqB+orJS94+fYNWbL9G07T5eKt5HNIALUItXQATy/x/hLLJPO5Sn2M3nOJYbEHhCc2rMQW9a7pO0CShQRcbar7ZRoRm1PlVFA2x+GKnyYsIC3IwkGxjPZgDBLMZXeMqPJim59r2UCjToThoG/gwo0MZLFBqnAOCmav+C1M1v6S6txHQ5apaNUjImLcNh2UU+AX6WAMjcWlRaWXtPsrXcM4+2rs5pk3XxdY6Z/DcZQY06AacENLnIyBDE5h2iqLVICtBghWmScXpeLePyfZ5wFH58hm2LeK93uPn2ekdx0IRUFOHx/5t5TiCxIXkjl7E7pFA/bwDXNd2tDPmKPqhv8b5dEaO6okaRWKKn/N0kh2a1j2hUpdsb9qp0ZF7Vn/N+UjQs2lvqkjO/B6MJTZX0MLIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2503.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(38100700002)(122000001)(82960400001)(38070700005)(83380400001)(52536014)(5660300002)(8936002)(186003)(86362001)(41300700001)(64756008)(66556008)(66446008)(55016003)(66946007)(7416002)(478600001)(4326008)(66476007)(7696005)(54906003)(6506007)(26005)(8676002)(110136005)(33656002)(9686003)(71200400001)(2906002)(316002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9dZx1UnyqqMVgYNKFyJBZ6mL48cOYckGsHaTWA7nBDv0SfaD7gMdLE/V2aDu?=
 =?us-ascii?Q?x0cVKEC1N4HxNQKsdGGtCG8ZbhxP7vnnAdcu8GshETL9yb7W63T3hy1Zf1q4?=
 =?us-ascii?Q?MZ9CHQbTexEFBP8WBGA2ozsRMvv9R9f8GZ2oUHUYPuJM+ELWpVoe02V7laLu?=
 =?us-ascii?Q?rr2CrBdwNvwcY9kB+qZu47uD1MfIFnYiknQm8tTD5SArBbr/sBuaAsLcbBDj?=
 =?us-ascii?Q?88PlYlZk3IlbIA1hbEZ+YvhhszNPWT4eUOKVzdEwCdy0CofJv78DWoVMugBl?=
 =?us-ascii?Q?YoXo7hHEJQXwzPL+bSa+RrpmmHxg6rN5RdJQ9lrH4T1o6qE+PB4CYsQA3Uxo?=
 =?us-ascii?Q?lfcL9ZIa2XeRxqo57YACtxPdlvMZYn2AZozTHbfUKiYpSGQsmcSiY0NZ0Gad?=
 =?us-ascii?Q?9V//rFEvLxpydSsrKDPyuz+yN/PKg34kneVgoxqkgzeOcnixjbVJR+flDDXZ?=
 =?us-ascii?Q?r6AmVNUWmAb363mXy6KL4OiZAP3aDg91SAOp4M0D7zMAJFMft6ADGm4X0ymE?=
 =?us-ascii?Q?heI33c112+IxFEG2fDBFPdtuEGnBbEpji+7rcosVL6IVomxGT4jAC10Vq8zw?=
 =?us-ascii?Q?15i7YBAfr8xG7fECSWCnIap1NR+SLx3Tfjw+HwnhikgzKAtjD3LXJJrHm/bR?=
 =?us-ascii?Q?0HfIaQdMqxK2WWI60mndU13RnSwRGAnFl2wUMbz1HQm8NC9zEMD90uaJzo9D?=
 =?us-ascii?Q?xkNWg+YOo2nsPsLSK8CkoCIpHXKTUasEFbJnfOxeb4uIHDpGoA/762J/zvgL?=
 =?us-ascii?Q?Fr4vKjB61su+vxtD+YU0KH7MkzrVk9p4iYmDE61eLjzeglVcvwUbDQwB+S0H?=
 =?us-ascii?Q?L+zYShIw9y6crX3lbt2/uiP6kqQoJvd3kTGucIDRdhnvwj/2m+pO5RGSzCml?=
 =?us-ascii?Q?mNX37bbrPiUDwPZvhHTrhV0WuP+Ld6iqcEkVI0VLNwtrTwiUq1H6+8ZHANcE?=
 =?us-ascii?Q?DVrRguu1ORMGCslF+aCdbve4Q+is+uLB0AwaInHvW/IUvXWqqNAXz4u8LqoT?=
 =?us-ascii?Q?9JsZ/5VY7/EdSQ/5Ho91FS46Y9sQEotqwhUUNpYcXCjqKJGozzZ9BsWPScld?=
 =?us-ascii?Q?mH5ItBQihrrR16cjYogp+iX+SLxDpAS1cRpetKtKos1cuI/CFi1WHX9R3nLF?=
 =?us-ascii?Q?zpuwcAkJWpN414WWwNm+p3GoY/LqQS8bGvPG+Sd5lEIE9yHVjT2+RSPQOiFc?=
 =?us-ascii?Q?IOI7wEDL+b+nHdB3/3B9x4UGovOMbB3maebtkhGZxO2bzMAo24aJOnoWCaDQ?=
 =?us-ascii?Q?tdhOvU/WgvocPFfpTfjoxBg4zQ+ImxKOd7COh/xjGslQo/cZcadRXpPyAR4o?=
 =?us-ascii?Q?rWGMqb5TWMBORbGBUchHnt6ZCDOFKdD3PN9GI/FjGOZfdnierTHuN9BAOdRi?=
 =?us-ascii?Q?cTg3YsLevfOL/PVIzjhC5qW3DjO5J8ZriCrcqfTlmJ/5pi8u3rdlHEcK9XuZ?=
 =?us-ascii?Q?BnW5JMxBnl2tvNFmOqV+Qa9B0MpwYZBBZq71SD8LD/ajl/6CJIlbtDhM7qyq?=
 =?us-ascii?Q?i++8GeCD/FAfqX8L6BCGe7GGjt4EeL7M7lkcB0VpbFK4k2t7cCdVmGQZy/XG?=
 =?us-ascii?Q?8/WzOShfYO5k3AREmQTKug5ngjmZ+enM/SooOq2J?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?4PxwPxYPODUjKLq4pgRS3z6PbNKno8roXitdWVdLRgPw1WnzBUEWEHWD5DuV?=
 =?us-ascii?Q?sDC8nAvrpu5zhJWVsGnpuObRSIX+JkqWq0td/TMMDd1F+KD0obYZFQ4p0U8x?=
 =?us-ascii?Q?EpcUJohcj38d9HzQaMsgA8YhnKUBpqnQ0VkMFMvoJ7PQn0tlLqa30kAjH0nk?=
 =?us-ascii?Q?B4DNQ7uSOOYX4XJJYPmEgDhurXoct1+kZDs085Iz4sT9FlBa5obuoq9TwzO7?=
 =?us-ascii?Q?F9JFM+BkIFU28+diUYPcVd5bmfFeup7CPSMbHpMP/j3IPWGQ6naJlGBtfWpo?=
 =?us-ascii?Q?bNUG/LpaoIOde1qfhyJ2/EKl1IZQ3y5S2WPAM5ar9+vKeOepshIkiNxumOCQ?=
 =?us-ascii?Q?I3UcOQXSPJ0UXFmjMKRKLl1Hy7taMpenRN73eAs/qDiNvCaI79abFVJNzQS6?=
 =?us-ascii?Q?dUKzQsUsQI2SwWhdENA9svSApGz5EYYUO6m3yCMuni6gIJi6WmgaCtbtnA91?=
 =?us-ascii?Q?f0YkH/5s8AFoAtBDDCvAJb+NiCMriKia4xviQwlf6X9c/8shW7NQx9HaBlnZ?=
 =?us-ascii?Q?8ErwDgb3EyGdWbNY8JvqhRVDZh5vOKM/FCyWULPSWKLhkLjh0gpL+f0vYYrx?=
 =?us-ascii?Q?MRnSzncfL9TmyTux3B539dsLi+5O7wlUeNZAJq7MQF48GEIUIpMvaZPcGB4y?=
 =?us-ascii?Q?aAtCtzsIjWPUeQqx1kXuBLLXm5BK6cU9zlYsOLuJaLgx3WzKtZXUZRTncrzc?=
 =?us-ascii?Q?OZMLa5uexJwJ3Yxwe7Jmi0IHepK+7h7sjDGcqm7+72lqYRvQd4wfl8OSTM/D?=
 =?us-ascii?Q?Mcc/nIfhLorUxoJwMHitEyGrpJrBJlves0kmq8yArKoZ8e8tTJ4oQEKzHeyd?=
 =?us-ascii?Q?RGNU9MIu0DTdlQmXjrXxWPtXbyge3gxk1+KL1tFuEd0y+WTjiH+Ss8IFE9tH?=
 =?us-ascii?Q?fqcrxhJuL96sfeSy1H3r1kXqKFchsGC5qrrvLSYHXs0NsEHJsCyoCp2q6zVG?=
 =?us-ascii?Q?rY6F2b45Oy/kxWpWo0l2RDBW+FjvnStpotbARsOTdBZbogJfqLg66sRoiadp?=
 =?us-ascii?Q?AcDemo6HjKNgD0aTqi21S8Mi28udbRzdzEiHDCbuIfkPLkSnqMFbLQDC7vwk?=
 =?us-ascii?Q?pX8gRAC3Natzx3fbP1c856N18rv+sbRa/Z3PBR1zsULGBXmt5zAa90sdsnOd?=
 =?us-ascii?Q?233e/WvYQQ+To8BQqNhsiYbUZPqHCa2eJThCurjTIiDYi3btCd661x/cBr9B?=
 =?us-ascii?Q?hg8oST/KyHP6XFqE/r0ocq2DIusZMN55xbjaDMdI8swSxuwxUUiFr/E7FJJZ?=
 =?us-ascii?Q?wxqvpksb+f8PGvlKNQIwkUOM/9JWVWcRo+c6SXef66Me8Lhz+QZJdud+SDap?=
 =?us-ascii?Q?UeUGAV2xajxo7VWPCR1uiWlmZQzG1Z5OMqmP5dyI4nrW4I03KYfCQ/jpGeQk?=
 =?us-ascii?Q?Ipz5oJIaU1LSZB6WffzUO7DrE383RZo1ReN12fgDngIJeDj0d5JDfV4e9+Vm?=
 =?us-ascii?Q?TzlVLpw50wNJoooKBTUd3uXJRzvAI4pAA6og55Zm7bIPDLXg43rCVVsQ15CC?=
 =?us-ascii?Q?T21d9dFnIWcvHGlW2c5S3JpGWQHCol9b6Q6fGFOshp7jpO///T+kKL6oXKZ1?=
 =?us-ascii?Q?P1HOzHc41jvmG51lk6nd3r5Irk9pDIocSqGmYRb31efkr4GI/AlOkP90NfBF?=
 =?us-ascii?Q?O9XsZ+SQxZ7IYxkJe4/Y+QKpVESGmp6F1b0NCWldoie/CfHNxbnan9SKs3yC?=
 =?us-ascii?Q?WgTQ3g=3D=3D?=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a557e534-237a-46a0-0e85-08da81fbd213
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 15:59:38.7428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JgGipfC0gV0WKd+dQlKEa6JaJqGakv5L5LuT9rzN36NMQxWqvrfRRuPEUMnz2DZ0hrnSmAQnAjuztWrrMSgT+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3446
X-Proofpoint-GUID: lS5Oec_ll5CcCpbdwCJ5JaShJByBNcOw
X-Proofpoint-ORIG-GUID: lS5Oec_ll5CcCpbdwCJ5JaShJByBNcOw
X-Sony-Outbound-GUID: lS5Oec_ll5CcCpbdwCJ5JaShJByBNcOw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_08,2022-08-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: Tales Aparecida <tales.aparecida@gmail.com>
>=20
> Describe the objective of the Getting Started page, which should be a
> brief and beginner-friendly walkthrough for running and writing tests,
> showing the reader where to find detailed instructions in other pages.
>=20
> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
> ---
>  Documentation/dev-tools/kunit/start.rst | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-=
tools/kunit/start.rst
> index f0ec64207bd3..3855402a5b3e 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -4,6 +4,11 @@
>  Getting Started
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> +This page contains an overview about the kunit_tool and Kunit framework,
> +teaching how to run existent tests and then how to write a simple test-c=
ase,
> +and covering common problems users face when using Kunit for the first t=
ime.
> +It is recommended that the reader had compiled the Kernel at least once =
before.

had -> has

before. -> before (what?? - reading these instructions?, running kunit?)

> +
>  Installing Dependencies
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  KUnit has the same dependencies as the Linux kernel. As long as you can
> --
> 2.37.1

