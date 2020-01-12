Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61BCD138BF7
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2020 07:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgAMGqt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jan 2020 01:46:49 -0500
Received: from mail02.vodafone.es ([217.130.24.81]:28185 "EHLO
        mail02.vodafone.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgAMGqt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jan 2020 01:46:49 -0500
IronPort-SDR: Rzha7B0fXX7EVJWZd4GzUWvKsuSUIOOqRRYzgAY/G9g0PbgdOzAz05XGu9+bjV/4a7weExnDOM
 a7KoUm0UJzlQ==
IronPort-PHdr: =?us-ascii?q?9a23=3AVdql8BDwnfYA1qdNNjFYUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPX7r8bcNUDSrc9gkEXOFd2Cra4d0KyM7fGrADRYqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmsswnct80bjYR/Jqot1h?=
 =?us-ascii?q?fCv2dFdflRyW50P1yYggzy5t23/J5t8iRQv+wu+stdWqjkfKo2UKJVAi0+P2?=
 =?us-ascii?q?86+MPkux/DTRCS5nQHSWUZjgBIAwne4x7kWJr6rzb3ufB82CmeOs32UKw0VD?=
 =?us-ascii?q?G/5KplVBPklCEKPCM//G3Ql8J/kLhUoBehphBm3YPUZ5uVNOJ5fqPHZ9waWX?=
 =?us-ascii?q?ROUt9PWCxHG4+xc5cPD/YbMulEr4nyuV4OogW4BQmwHe/g1DlIimbx06091e?=
 =?us-ascii?q?QuDwHH0BU+ENIIrX/YqNv4OLsOXeywyqTD0DfNYO5M2Trl5obGcgohr++PU7?=
 =?us-ascii?q?xtfsXe1UYhGhjZjliStYPpIy+Z2vgTv2Wd8uFuVfivi2kiqwxpuDag2NsshZ?=
 =?us-ascii?q?fThokIyl/E8iN5wIkoLtC/UE50f8KkH4VKtyCUMIt2RMwiTnpouCYh0bIJpY?=
 =?us-ascii?q?S3czQNyJQi3RLfa/+HfpGO7xn+V+iROS91iGx4dL+9nRq+7EatxvHmWsWq31?=
 =?us-ascii?q?tGtCRIn9nKu3sQzRLc8NKHReF4/kq53DaP0B3c5f9cLEAvkKrbN4Yhwrktlp?=
 =?us-ascii?q?oPqUjDHjH5mEHxjKKOc0Ur4Omo6+D9Yrr4op+QK4B5hhvgMqQph8OwG+o4Mg?=
 =?us-ascii?q?8IX2eF4+izyqbj8VX4QLVMkPI2jrHUvI7HKckZvKK1HgFY3po55xqhADqqyt?=
 =?us-ascii?q?oVkHkfIFJAYh2HjozpO1/UIPD/CPeym0ysnyl3x//YJL3gDJLNLn7MkLr6fb?=
 =?us-ascii?q?Z98FVTxxYpwd9D4JJUD6sNIPLwWkPprtzXEgc5MxCow+bgENh90oIeWWSSAq?=
 =?us-ascii?q?6WKa/SskSI6fwrI+mCeI8api39K+Q+6v7wgn82h0UdcbOq3ZQJcnC4GOppI0?=
 =?us-ascii?q?GDbXrrmNcBHjRCgg1rSO3slU3HUiVeY3iuUrkgzi80BZjgDorZQI2pxrub03?=
 =?us-ascii?q?SBE4VSd1xBX2iBDXryP7qDXfhEPDqfPsJ7jTsCWriiS5Qr3jmhsQb7z/xsKe?=
 =?us-ascii?q?+CqQMCspe27NVp6vebqhY0+nQgF8mB3nuSSGd7tmMTTTRw16d650x+nATQmZ?=
 =?us-ascii?q?NkiuBVQIUAr8hCVR03YMWEl+E=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ETKgAeERxemCMYgtkUBjMYGgEBAQE?=
 =?us-ascii?q?BAQEBAQMBAQEBEQEBAQICAQEBAYF7AgEBFwEBgS6BTVIgEpNQgU0fg0OLY4E?=
 =?us-ascii?q?Agx4VhggTDIFbDQEBAQEBNQIBAYRATgEXgQ8kOgQNAgMNAQEFAQEBAQEFBAE?=
 =?us-ascii?q?BAhABAQEBAQYNCwYphUqCHQweAQQBAQEBAwMDAQEMAYNdBxkPOUpMAQ4BU4M?=
 =?us-ascii?q?EgksBATOFJJc5AY0EDQ0ChR2CRAQKgQmBGiOBNgGMGBqBQT+BIyGCKwgBggG?=
 =?us-ascii?q?CfwESAWyCSIJZBI1CEiGBB4gpmBeCQQR2iUyMAoI3AQ+IAYQxAxCCRQ+BCYg?=
 =?us-ascii?q?DhE6BfaM3V4EMDXpxMxqCJhqBIE8YDYgbji1AgRYQAk+JLoIyAQE?=
X-IPAS-Result: =?us-ascii?q?A2ETKgAeERxemCMYgtkUBjMYGgEBAQEBAQEBAQMBAQEBE?=
 =?us-ascii?q?QEBAQICAQEBAYF7AgEBFwEBgS6BTVIgEpNQgU0fg0OLY4EAgx4VhggTDIFbD?=
 =?us-ascii?q?QEBAQEBNQIBAYRATgEXgQ8kOgQNAgMNAQEFAQEBAQEFBAEBAhABAQEBAQYNC?=
 =?us-ascii?q?wYphUqCHQweAQQBAQEBAwMDAQEMAYNdBxkPOUpMAQ4BU4MEgksBATOFJJc5A?=
 =?us-ascii?q?Y0EDQ0ChR2CRAQKgQmBGiOBNgGMGBqBQT+BIyGCKwgBggGCfwESAWyCSIJZB?=
 =?us-ascii?q?I1CEiGBB4gpmBeCQQR2iUyMAoI3AQ+IAYQxAxCCRQ+BCYgDhE6BfaM3V4EMD?=
 =?us-ascii?q?XpxMxqCJhqBIE8YDYgbji1AgRYQAk+JLoIyAQE?=
X-IronPort-AV: E=Sophos;i="5.69,428,1571695200"; 
   d="scan'208";a="323859898"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail02.vodafone.es with ESMTP; 13 Jan 2020 07:46:47 +0100
Received: (qmail 24269 invoked from network); 12 Jan 2020 05:00:20 -0000
Received: from unknown (HELO 192.168.1.3) (quesosbelda@[217.217.179.17])
          (envelope-sender <peterwong@hsbc.com.hk>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-kselftest@vger.kernel.org>; 12 Jan 2020 05:00:20 -0000
Date:   Sun, 12 Jan 2020 06:00:19 +0100 (CET)
From:   Peter Wong <peterwong@hsbc.com.hk>
Reply-To: Peter Wong <peterwonghkhsbc@gmail.com>
To:     linux-kselftest@vger.kernel.org
Message-ID: <6904412.460747.1578805220278.JavaMail.cash@217.130.24.55>
Subject: Investment opportunity
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Greetings,
Please read the attached investment proposal and reply for more details.
Are you interested in loan?
Sincerely: Peter Wong




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

