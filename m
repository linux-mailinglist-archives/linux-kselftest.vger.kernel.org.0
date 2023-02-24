Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C016A1D7C
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Feb 2023 15:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjBXOcU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 09:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjBXOcT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 09:32:19 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2106.outbound.protection.outlook.com [40.92.75.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA77A66289;
        Fri, 24 Feb 2023 06:32:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVEVhRg+msxHBgKZ3Y5YR1GLQLCstyoN1NY9P2TcTZufLync1PTAYSaLGwlYt+P8srrDxvTnVUiyZQbR0YWCMxQOYHhm1oSktdCPZCMad+Tinjxu4U2mCS+BrVCcOVFNIMuwiNjXj39LZhikthjpnA78bMn4I3cVLgmCYsN4vbpX0FnFfptGnCMkBikXiwlUANK7zjkWChGNQY3DK7JQPqVsHVWshX5dj9dW1hc7+toNGA3Q+IEythvP0uSibnRBtTJhDgp1uqfYJTYuvCpOdMePgrDGCqP/6OxMa2ffsAruPiPjA8cmWq3EquAmpHHi+6jAKM4JQ/JxO1NL/LJl2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnRFYmEZaozlnALSMjpHLYhqHUizZQfd6+8vypj2laQ=;
 b=brJoi4LcPhg/IDSe7xvDzDm22AYdlvsfpxZL3eqDzkyOwD2/zVdHwxUhsM2Geb9gtN3XRVewu4U8GCxcybWr+8uwpUlNropAqvKXQmpSfG39aQQX1N2joXy7W1xllFccS+6oKnq/f55rbpHWMKa/9i6td1A/ZLfKP69yRSP3imPi8ttn5bzZTYSe+QSuwEJV48tAL9CsSMVd7ADbQtS2Ytiz2bpwVy+YDaIzLxj3dpdJ7G/PhCdke5LZJEDEPBaNY7Hp0QPCl/REVPvHOx7YfKYVbOKNc6NDjsOw7MwrzPQvqiCFte2KKZahyGZOVDh6zWF8lQQ1DOly35x9kNk5pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnRFYmEZaozlnALSMjpHLYhqHUizZQfd6+8vypj2laQ=;
 b=qSsZnQRlHnUEnVewDnYzUyafLCnES8u/ZYlh2szvq0nMo6Qjdw4CBLF4sYWtjHymFSumgbnJAm80PaQmMGOOAPOW7pSD07/w7bpDnOL9MF+tNfDv0dq5WsIFCHfqDQjUwNfu32XMqlal+Q+vETb8dbMv2YCYyik3gGu5PNhNoc87ZfaInOQy+yh50oH871nUDLk89hBubNjBZyGHmz2NeDoAMVzQNLE/y15UxDwbP+bnNd0SuGlP6xCKI+qCMCaPbwBZS8J+QfGrLjJDnMtNw73rpxbj+TfhLGC/3btl9YfX3rfO8fRP/YX3PjxqTAb/Ria0geSboItbD84Ixva1cw==
Received: from DB6P189MB0568.EURP189.PROD.OUTLOOK.COM (2603:10a6:6:31::16) by
 VE1P189MB0943.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:14b::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.24; Fri, 24 Feb 2023 14:32:09 +0000
Received: from DB6P189MB0568.EURP189.PROD.OUTLOOK.COM
 ([fe80::4a20:e1a:db8c:28d9]) by DB6P189MB0568.EURP189.PROD.OUTLOOK.COM
 ([fe80::4a20:e1a:db8c:28d9%3]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 14:32:09 +0000
From:   David Binderman <dcb314@hotmail.com>
To:     "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Possible bug in
 linux-6.2/tools/testing/selftests/powerpc/pmu/sampling_tests/mmcra_thresh_marked_sample_test.c
Thread-Topic: Possible bug in
 linux-6.2/tools/testing/selftests/powerpc/pmu/sampling_tests/mmcra_thresh_marked_sample_test.c
Thread-Index: AQHZSFvUqaHxvh3GpEagi2vrvvWGhQ==
Date:   Fri, 24 Feb 2023 14:32:09 +0000
Message-ID: <DB6P189MB0568CF002762C6C43AF6DF169CA89@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [xQlDjAvViMbcvsFWAOSciphl5Y5Ikl5y]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB6P189MB0568:EE_|VE1P189MB0943:EE_
x-ms-office365-filtering-correlation-id: 952e2806-2993-4b32-5e29-08db1673e958
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q/Q//Fkdo+k7QR5bXKSB6O5e3Y+6t05VmfWnO1OTZhVpr7baDt/Mjtb1g7iExWFdUERT3EMd7sbfLeupR2P+fwYUYH6AXfG2KVL6BXqOgXHkCP3Mc/gXHVmRU3GBgR8l1ndwknL/8cCqowmuXatHsRIou51LoB6rA7pvs/6zae1+7hX9Tle6BXAMiY8Ew2YGhHbIwYEM0Qv1py52ItNJhLuqSCNn4SSh2jesmhc+715J8NJrYDMHO4EyUOJGcU/e2AOLycMOn75rl4h7k+H22u1qeOgya/koBcG2sfBXbgJZ0lSN5A7lzIQeYnx74G8AiwOYm+HLo2OYavtcuxD/rVJqW4DHVcpqWLKkCGsXn6WgOgOhQ5nkfpLGM4F+zDsIRZY32U4g0AzucE/vNuf7o7lMRpx/K5Y7Ph3EYQAeBoRchcc/YaHmbOK8nuuytwdn7dPrtLUu/txDg6FrdcHj78UqBaCKXs0/RjBRDdfHMOTsxqgu8lQUMS/Ip0L6e5tCFYMqF9em4CG0tPi+27buh1c2LxtydEu7YXbN4itNS0ULAHIZCSDFv4/m864TKhyLiCe1SOPOMRVoHQS6tQGOvENSP+ZBH58C4oW8UuwWOcM=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qFIVy7F1dzwYAXTcp2DfRWpQoSagiSeeo8zo/95Et7jsgJXoMR1PZirgbx?=
 =?iso-8859-1?Q?S+UzdSd3PHhSUZlCIR4OhmCafdi4uShxGwIaoVTZ5+J+Y+zSJVP/IWE4x7?=
 =?iso-8859-1?Q?R1fz7TiC1yCmGjUsRCTymP3HaNPkwq//A9hD3+g5VbPXEwFYkcgjt7icSI?=
 =?iso-8859-1?Q?SwBeCLtxx71r7Xe23SffjtG9SMAw1zYgSP/+ZeaCk8XEPuwJCOy6vPn9OO?=
 =?iso-8859-1?Q?fmh7L60qByktcFdnhiojnr6/Dy8lQK7jgSdydhTfBcDTkvUkO/Fay3E2eT?=
 =?iso-8859-1?Q?y7Cjj/+epV2a6h0vIfXQbR4oYNW+MV5vGxyU8S7XhzM+vlc6zlZKZhk2Uz?=
 =?iso-8859-1?Q?Cvnthj2EFhpPljKXSfZ6NX/SGZh7meL+yLeXE1v7Gr9ykwr5it9S2iAPzF?=
 =?iso-8859-1?Q?sJ17HYtBvyhl0M0TW2ExOntjgBF1Jceya0Hx9SPdUeDvp4+pbdqpYEl5cS?=
 =?iso-8859-1?Q?ioG1XW4MkpvLkgJCYZ4TuxyU51rERwVzvcWO7QtlDDJlYumi5Hi5QOazIG?=
 =?iso-8859-1?Q?41wUEv0MA+g2e/djIQunnCJEMKJySuuzEpECyOyLPdYYY91u4kP2wiFy4p?=
 =?iso-8859-1?Q?wVIzVdaXTXG5M+M6Q5JwvO1TV8bM4f8emm8o/f6L6iaU5Ai7vdIE83lqWJ?=
 =?iso-8859-1?Q?/H9WveuFJJeL1pQ8MtiQUNA26sHBiSCCSfoajQ97lb2kknMY3Ixk8NzbWr?=
 =?iso-8859-1?Q?HZG6i+4OPpmTEE1rOr6KDQvM2f24wikYiZeg5bRCyarff/Zezk2+0MUVO7?=
 =?iso-8859-1?Q?Rpj+UW53kJTKfvLn4YzZKWAq0vgRfgKsDghzJTOXNt9BQT9ETukoO8AlV5?=
 =?iso-8859-1?Q?7OJFuG/cF+rTC2vU1kNsFgCT5gBdPeRh98rGAE2OmF2Pw/hR1RmtwXW1P/?=
 =?iso-8859-1?Q?7SfArqOg7xHP0L/AJf3WkLw07c4zSiLO7wbPmQOUIZo9NeOLpQy4CACr95?=
 =?iso-8859-1?Q?lpEf3jGuGonFgzQYEMSW4dNeHeSTAmHdZSfQVj2awFFjGiCjrAXd+U2+9k?=
 =?iso-8859-1?Q?Jmx5ilxeqJdvV3v1CAn5yAjx4bYl5MQE/XLDoSoFMDznnC+Q3anPufVxZA?=
 =?iso-8859-1?Q?hN/t//z3OON76VHwlf1iuKH1L2PO/iqDTopM+j0j9DX0hYD13/uSvZK+p5?=
 =?iso-8859-1?Q?gimJtpmMsCMuwwulprpZAifBZH86Zv35cmaTCYx2lHkFSm8DYQ9PrFaSxK?=
 =?iso-8859-1?Q?HY0ooE3+VfUIXSjFwaPuSlIQqOoHQ5Zi5VN8MSkP9crC4EX63ziaqmhV+4?=
 =?iso-8859-1?Q?nltmptp2WEts634Jdb06mXRxc6G1LSIwaxBNewxSBlmsvVvrdIsU4hk3Q2?=
 =?iso-8859-1?Q?ZSgb?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c54b5.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6P189MB0568.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 952e2806-2993-4b32-5e29-08db1673e958
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 14:32:09.4677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P189MB0943
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello there,=0A=
=0A=
I ran the static analyser cppcheck over the linux-6.2 source code and got t=
his:=0A=
=0A=
linux-6.2/tools/testing/selftests/powerpc/pmu/sampling_tests/mmcra_thresh_m=
arked_sample_test.c:68:10: style: Same expression '0x3' found multiple time=
s in chain of '&' operators. [duplicateExpression]=0A=
=0A=
Source code is=0A=
=0A=
    FAIL_IF(EV_CODE_EXTRACT(event.attr.config, sample & 0x3) !=3D=0A=
            get_mmcra_sample_mode(get_reg_value(intr_regs, "MMCRA"), 4));=
=0A=
=0A=
but=0A=
=0A=
#define EV_CODE_EXTRACT(x, y)   \=0A=
    ((x >> ev_shift_##y) & ev_mask_##y)=0A=
=0A=
=0A=
Given the token pasting, I very much doubt an expression like "sample & 0x3=
"=0A=
will work correctly. Same thing on the line above =0A=
=0A=
    FAIL_IF(EV_CODE_EXTRACT(event.attr.config, sample >> 2) !=3D=0A=
            get_mmcra_rand_samp_elig(get_reg_value(intr_regs, "MMCRA"), 4))=
;=0A=
=0A=
"sample >> 2" doesn't look like a valid token to me.=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=
=0A=
=0A=
