Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992F87B5FBE
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Oct 2023 06:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239053AbjJCERT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Oct 2023 00:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239057AbjJCERN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Oct 2023 00:17:13 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1A7C6
        for <linux-kselftest@vger.kernel.org>; Mon,  2 Oct 2023 21:17:10 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f61a639b9so7894727b3.1
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Oct 2023 21:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696306629; x=1696911429; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xVHKEQiikdMgbU+y27225hg2LnDyDOWoRLfGIfsc16c=;
        b=B9VnI/1U+P3xlO4fshby72X1h0LoXSFnHMrojuo6YWrsKx3lPVsRzgBGYUPvKTcBGK
         FcDjpFGTsF8FMbho+oWi11Zr2vpj/IrIDZm4firEiv0SkSPlnyZKPlvcj/CM9DK976cA
         xAITZzRrXuR6nGTe6iPkLbJbvGQK1ukPIEOXVVHuDGbPH4G0MICihiBssgdWgPbWzEIW
         ju0iCM2CC8ow2EIEUNXUFgKh4eSUUS5N6SQyEMz9fyga3VF8Wom/LeWIinyTyLNKHpfy
         NcHJe67AvH1rq8VVyX/7hA7zZTG1kVWSaO9FezEwWZGi9IoiV8mRia8fsG8Ff+KyzGAY
         aLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696306629; x=1696911429;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xVHKEQiikdMgbU+y27225hg2LnDyDOWoRLfGIfsc16c=;
        b=XIB8iioQotK5LVRRKdNmqb2SyIZuBSZ3ghBFVm3TR0B3Hw79Vy4jEz1L/L6lxCmv7u
         FWU5ehg4aX3woQvxr8DT3Fs2KQ8R9XKbRsKt4sLIGZ2RFnA1KuuRGexojJ7R/rCYiti6
         4bNNEwjc1asCW7TPff2mBSX5PzRS6H0VB+6SJdIb9yB2ND5DnIAiRiM9k8Jhl4vHdNO6
         JRkIZaQYW8ArsqmfynFUfDyaUbeptR/YetG+gDUN4A9JwfZlrr5dysoB69zFuCoA2VQ5
         Nya6P7nHQpAuFpQhxx6WJlJ+t9l9RAG8G3z3tyF5NaX6kRxGIUxONXNcHIkMkwTxFjNr
         FVUQ==
X-Gm-Message-State: AOJu0YzLgxL68FHCNrW7TmhhZOd0VrUcnFpYC1YxPV35NvfELhmmfVVm
        r+zLqNfDnk8XZgHaaCbsUnesE6NFEbiN
X-Google-Smtp-Source: AGHT+IFqdsv7HPhJyVpjFa70cd8lqSqqjzyGMmf+x/TfZsWhqaKDgORtG52OMlda2Z5v7xXb0p2XiHtPY4bs
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2b7a])
 (user=maheshb job=sendgmr) by 2002:a25:abaf:0:b0:d7b:9830:c172 with SMTP id
 v44-20020a25abaf000000b00d7b9830c172mr211752ybi.0.1696306629637; Mon, 02 Oct
 2023 21:17:09 -0700 (PDT)
Date:   Mon,  2 Oct 2023 21:17:06 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231003041706.1746634-1-maheshb@google.com>
Subject: [PATCHv2 next 3/3] selftes/ptp: extend test to include ptp_gettimex64any()
From:   Mahesh Bandewar <maheshb@google.com>
To:     Netdev <netdev@vger.kernel.org>,
        Linux <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>,
        Don Hatchett <hatch@google.com>,
        Yuliang Li <yuliangli@google.com>,
        Mahesh Bandewar <mahesh@bandewar.net>,
        Mahesh Bandewar <maheshb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

add -y/-Y options to support PTP_SYS_OFFSET_ANY2 op. where -y represents
samples to collect while -Y is to choose the timebase from available
options of cycles, real, mono, or raw.

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
CC: Shuah Khan <shuah@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>
CC: Rahul Rameshbabu <rrameshbabu@nvidia.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: linux-kselftest@vger.kernel.org
CC: netdev@vger.kernel.org
---
 tools/testing/selftests/Makefile      |  1 +
 tools/testing/selftests/ptp/testptp.c | 76 ++++++++++++++++++++++++++-
 2 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 42806add0114..c5e59cfc9830 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -66,6 +66,7 @@ TARGETS += powerpc
 TARGETS += prctl
 TARGETS += proc
 TARGETS += pstore
+TARGETS += ptp
 TARGETS += ptrace
 TARGETS += openat2
 TARGETS += resctrl
diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index c9f6cca4feb4..549f0861e897 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -37,6 +37,12 @@
 
 #define NSEC_PER_SEC 1000000000LL
 
+static char *time_base_arr[PTP_TS_MAX] = {
+	"system time",
+	"monotonic time",
+	"raw-monotonic time",
+};
+
 /* clock_adjtime is not available in GLIBC < 2.14 */
 #if !__GLIBC_PREREQ(2, 14)
 #include <sys/syscall.h>
@@ -145,8 +151,10 @@ static void usage(char *progname)
 		" -T val     set the ptp clock time to 'val' seconds\n"
 		" -x val     get an extended ptp clock time with the desired number of samples (up to %d)\n"
 		" -X         get a ptp clock cross timestamp\n"
+		" -y val     get an extended-any ptp clock time with the desired number of samples (up to %d) with given time-base for sandwich (with -Y opt)\n"
+		" -Y val     sandwich timebase to use {real|mono|raw}\n"
 		" -z         test combinations of rising/falling external time stamp flags\n",
-		progname, PTP_MAX_SAMPLES);
+		progname, PTP_MAX_SAMPLES, PTP_MAX_SAMPLES);
 }
 
 int main(int argc, char *argv[])
@@ -162,6 +170,7 @@ int main(int argc, char *argv[])
 	struct ptp_sys_offset *sysoff;
 	struct ptp_sys_offset_extended *soe;
 	struct ptp_sys_offset_precise *xts;
+	struct ptp_sys_offset_any *ats;
 
 	char *progname;
 	unsigned int i;
@@ -182,6 +191,8 @@ int main(int argc, char *argv[])
 	int pct_offset = 0;
 	int getextended = 0;
 	int getcross = 0;
+	int get_ext_any = 0;
+	int ext_any_type = -1;
 	int n_samples = 0;
 	int pin_index = -1, pin_func;
 	int pps = -1;
@@ -196,7 +207,7 @@ int main(int argc, char *argv[])
 
 	progname = strrchr(argv[0], '/');
 	progname = progname ? 1+progname : argv[0];
-	while (EOF != (c = getopt(argc, argv, "cd:e:f:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:Xz"))) {
+	while (EOF != (c = getopt(argc, argv, "cd:e:f:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:Xy:Y:z"))) {
 		switch (c) {
 		case 'c':
 			capabilities = 1;
@@ -273,6 +284,29 @@ int main(int argc, char *argv[])
 		case 'X':
 			getcross = 1;
 			break;
+		case 'y':
+			get_ext_any = atoi(optarg);
+			if (get_ext_any < 1 || get_ext_any > PTP_MAX_SAMPLES) {
+				fprintf(stderr,
+					"number of extended-any timestamp samples must be between 1 and %d; was asked for %d\n",
+					PTP_MAX_SAMPLES, get_ext_any);
+				return -1;
+			}
+			break;
+		case 'Y':
+			if (!strcasecmp(optarg, "real"))
+				ext_any_type = PTP_TS_REAL;
+			else if (!strcasecmp(optarg, "mono"))
+				ext_any_type = PTP_TS_MONO;
+			else if (!strcasecmp(optarg, "raw"))
+				ext_any_type = PTP_TS_RAW;
+			else {
+				fprintf(stderr,
+					"type needs to be one of real,mono,raw only; was given %s\n",
+					optarg);
+				return -1;
+			}
+			break;
 		case 'z':
 			flagtest = 1;
 			break;
@@ -286,6 +320,14 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	/* For ptp_sys_offset_any both options 'y' and 'Y' must be given */
+	if (get_ext_any > 0 && ext_any_type == -1) {
+		fprintf(stderr,
+			"For extended-any TS both options -y, and -Y are required.\n");
+		usage(progname);
+		return -1;
+	}
+
 	fd = open(device, O_RDWR);
 	if (fd < 0) {
 		fprintf(stderr, "opening %s: %s\n", device, strerror(errno));
@@ -604,6 +646,36 @@ int main(int argc, char *argv[])
 		free(xts);
 	}
 
+	if (get_ext_any) {
+		ats = calloc(1, sizeof(*ats));
+		if (!ats) {
+			perror("calloc");
+			return -1;
+		}
+
+		ats->n_samples = get_ext_any;
+		ats->ts_type = ext_any_type;
+
+		if (ioctl(fd, PTP_SYS_OFFSET_ANY2, ats)) {
+			perror("PTP_SYS_OFFSET_ANY2");
+		} else {
+			printf("extended-any timestamp request returned %d samples\n",
+			       get_ext_any);
+
+			for (i = 0; i < get_ext_any; i++) {
+				printf("sample #%2d: %s before: %lld.%09u\n",
+				       i, time_base_arr[ext_any_type],
+				       ats->ts[i][0].sec, ats->ts[i][0].nsec);
+				printf("            phc time: %lld.%09u\n",
+				       ats->ts[i][1].sec, ats->ts[i][1].nsec);
+				printf("            %s after: %lld.%09u\n",
+				       time_base_arr[ext_any_type],
+				       ats->ts[i][2].sec, ats->ts[i][2].nsec);
+			}
+		}
+
+		free(ats);
+	}
 	close(fd);
 	return 0;
 }
-- 
2.42.0.582.g8ccd20d70d-goog

