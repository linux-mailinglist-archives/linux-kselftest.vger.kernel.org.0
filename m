Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459D6610B1A
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Oct 2022 09:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJ1HQn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Oct 2022 03:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJ1HQm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Oct 2022 03:16:42 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86203197F89;
        Fri, 28 Oct 2022 00:16:40 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29S7DwZc019319;
        Fri, 28 Oct 2022 07:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=EjCOeQyXT0aGcdkooJqazRFVr2g9e46QYc/oxVXwpVE=;
 b=oDB6e9jHvsTBchO4yW2xYVZw3ze+V2Og87awntCQRGTeKd7WqxgxfUsxPgFIN7vXqmYK
 g4K2yY8AfBCvSybRiPllFlU0HCkKTVwpwthMDSh3whnHB6GfCK5K3WT6lpi/Up6nAayr
 DT+0C7/f1pKdLYWr3h8CHbNOPjHTCkSVSFqyDqrk6h5m8j1FXzQp+/KbaFeQWcZ+rbdH
 jWrKV/SZXKKWo7xLqE9H8dD9sKnKz3EuHTH9sJrv/kZECtla8CI76nwmRp2AIAtJxfZX
 1a7UtrCZ3wgZfR6zOON7STO7LDcfT9U0NcVfnB3/eyXW+cmIYcqvMlPQiWDWy1u2vP0H kg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kgagvr236-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 07:16:36 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29S7Er7Q030458;
        Fri, 28 Oct 2022 07:16:34 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3kg0f90j66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 07:16:34 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29S7H7G353150052
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 07:17:07 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17A66A4051;
        Fri, 28 Oct 2022 07:16:32 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2713EA4057;
        Fri, 28 Oct 2022 07:16:30 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.57.156])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Oct 2022 07:16:29 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Akanksha J N <akanksha@linux.vnet.ibm.com>
Subject: [RESEND PATCH v2 0/2] selftests/ftrace: Capture dependency on external programs
Date:   Fri, 28 Oct 2022 12:46:08 +0530
Message-Id: <cover.1666941090.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DXDKeHmFGStPZZj7duR3tlolGgTh8taB
X-Proofpoint-ORIG-GUID: DXDKeHmFGStPZZj7duR3tlolGgTh8taB
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_03,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 mlxlogscore=961 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a repost of v2 with the tags collected, and with cc to 
linux-kselftest list:
https://lore.kernel.org/all/cover.1666101523.git.naveen.n.rao@linux.vnet.ibm.com/

- Naveen


Naveen N. Rao (2):
  selftests/ftrace: Add check for ping command for trigger tests
  selftests/ftrace: Convert tracer tests to use 'requires' to specify
    program dependency

 tools/testing/selftests/ftrace/test.d/functions           | 8 +++++++-
 tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc    | 7 +------
 tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc | 7 +------
 .../trigger/inter-event/trigger-field-variable-support.tc | 2 +-
 .../inter-event/trigger-inter-event-combined-hist.tc      | 2 +-
 .../trigger/inter-event/trigger-onchange-action-hist.tc   | 2 +-
 .../trigger/inter-event/trigger-onmatch-action-hist.tc    | 2 +-
 .../inter-event/trigger-onmatch-onmax-action-hist.tc      | 2 +-
 .../trigger/inter-event/trigger-onmax-action-hist.tc      | 2 +-
 .../trigger/inter-event/trigger-snapshot-action-hist.tc   | 2 +-
 .../inter-event/trigger-synthetic-event-dynstring.tc      | 2 +-
 .../trigger/inter-event/trigger-trace-action-hist.tc      | 2 +-
 12 files changed, 18 insertions(+), 22 deletions(-)


base-commit: cb05c81ada76a30a25a5f79b249375e33473af33
-- 
2.38.0

